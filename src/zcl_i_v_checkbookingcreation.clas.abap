CLASS zcl_i_v_checkbookingcreation DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_v_supercl_simple
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.

  METHODS /bobf/if_frw_validation~execute
    REDEFINITION .
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_i_v_checkbookingcreation IMPLEMENTATION.



  METHOD /bobf/if_frw_validation~execute.
  DATA bookings TYPE zti01_bookingtp.
  DATA message TYPE REF TO zcm_01_bookings.




        " Daten lesen
    io_read->retrieve(
      EXPORTING
        iv_node       = is_ctx-node_key
        it_key        = it_key
     "   it_requested_attributes = IF_
      IMPORTING
        eo_message    = eo_message
        et_data       = bookings
        et_failed_key = et_failed_key ).

    " Nachrichten-Container erstellen
    IF eo_message IS NOT BOUND.
      eo_message = /bobf/cl_frw_factory=>get_message( ).
    ENDIF.


"Noch eingrenzen auf nicht ausgebuchte Buchungen?
    SELECT spfli~connid
    FROM spfli "join sflight on spfli~connid = sflight~connid
    "where sflight~seatsmax - sflight~seatsocc > 0
    INTO TABLE @DATA(lt_valid_conn).

    SELECT bookid
    FROM sbook
    INTO TABLE @DATA(lt_usedbookings).

"hochziehen vor Loop?
      DATA(lv_match) = abap_false.
      DATA(lv_connmatch) = abap_false.
      DATA(lv_bookexist) = abap_false.
      DATA(lv_custexist) = abap_false.
      DATA(lv_avfldate) = abap_false.
      DATA(lv_avcarrier) = abap_false.
      DATA(lv_seatsavailable) = abap_true.

    LOOP AT bookings ASSIGNING FIELD-SYMBOL(<booking>).

    SELECT carrid
    FROM spfli
  "  WHERE  connid = @<booking>-connectionid
    INTO TABLE @DATA(lt_scarr).

    "Table of available flight dates for defined connid
    SELECT fldate, carrid
    FROM sflight
    WHERE  connid = @<booking>-connectionid
    INTO TABLE @DATA(lt_avfldates).

    SELECT id
    FROM scustom
    INTO TABLE @DATA(lt_defcustomers).

    SELECT connid
    FROM sflight
    WHERE seatsmax - seatsocc <= 0 AND connid = @<booking>-connectionid AND fldate = @<booking>-flightdate
    INTO TABLE @DATA(lt_avconns).



      LOOP AT lt_valid_conn ASSIGNING FIELD-SYMBOL(<realconn>).
      IF <booking>-connectionid = <realconn>.
      lv_connmatch = abap_true.
      ENDIF.
      ENDLOOP.

      "User hat nicht existierende Connection angegeben
      IF lv_connmatch = abap_false.
              message = NEW zcm_01_bookings(
          textid   = zcm_01_bookings=>co_incon_connid
          severity = zcm_01_bookings=>co_severity_error
        ).
        et_failed_key = VALUE #( BASE et_failed_key ( key = <booking>-key ) ).
        eo_message->add_cm( message ).
        CONTINUE.
      ENDIF.

"Flight Date für Connection nicht verfügbar
      LOOP AT lt_avfldates ASSIGNING FIELD-SYMBOL(<avfldate>).
      IF <avfldate>-fldate = <booking>-flightdate.
      lv_avfldate = abap_true.
      ENDIF.
      IF <avfldate>-carrid = <booking>-carrierid.
      lv_avcarrier = abap_true.
      ENDIF.
      ENDLOOP.


      IF lv_avfldate = abap_false.
              message = NEW zcm_01_bookings(
          textid   = zcm_01_bookings=>co_nav_flightd
          severity = zcm_01_bookings=>co_severity_error
        ).
        et_failed_key = VALUE #( BASE et_failed_key ( key = <booking>-key ) ).
        eo_message->add_cm( message ).
        CONTINUE.
      ENDIF.

      IF lv_avcarrier = abap_false.
          message = NEW zcm_01_bookings(
          textid   = zcm_01_bookings=>co_nav_carrier
          severity = zcm_01_bookings=>co_severity_error
        ).
        et_failed_key = VALUE #( BASE et_failed_key ( key = <booking>-key ) ).
        eo_message->add_cm( message ).
        CONTINUE.
      ENDIF.




      LOOP AT lt_scarr ASSIGNING FIELD-SYMBOL(<realcarrier>).
      IF <booking>-carrierid = <realcarrier>-carrid.
      lv_match = abap_true.
      ENDIF.
      ENDLOOP.

    "User hat nicht existierende Airline angegeben
      IF lv_match = abap_false.
          message = NEW zcm_01_bookings(
          textid   = zcm_01_bookings=>co_noex_carrier
          severity = zcm_01_bookings=>co_severity_error
        ).
        et_failed_key = VALUE #( BASE et_failed_key ( key = <booking>-key ) ).
        eo_message->add_cm( message ).
        CONTINUE.


      ENDIF.

"Wird über Determination gesteuert
*      LOOP AT lt_usedbookings ASSIGNING FIELD-SYMBOL(<usedbooking>).
*      IF <usedbooking>-bookid = <booking>-bookingid.
*      lv_bookexist = abap_true.
*      ENDIF.
*      ENDLOOP.
*
*    "User hat nicht existierende Airline angegeben
*      IF lv_bookexist = abap_true.
*              message = NEW zcm_01_bookings(
*          textid   = zcm_01_bookings=>co_alex_booking
*          severity = zcm_01_bookings=>co_severity_error
*        ).
*        et_failed_key = VALUE #( BASE et_failed_key ( key = <booking>-key ) ).
*        eo_message->add_cm( message ).
*        CONTINUE.
*      ENDIF.

      "Booking ist schon ausgebucht
      LOOP AT lt_avconns ASSIGNING FIELD-SYMBOL(<navconns>).
      IF <navconns>-connid = <booking>-connectionid.
      lv_seatsavailable = abap_false.
      ENDIF.
      ENDLOOP.

    "User hat nicht existierende Airline angegeben
      IF lv_seatsavailable = abap_false.
              message = NEW zcm_01_bookings(
          textid   = zcm_01_bookings=>co_fullybooked
          severity = zcm_01_bookings=>co_severity_error
        ).
        et_failed_key = VALUE #( BASE et_failed_key ( key = <booking>-key ) ).
        eo_message->add_cm( message ).
        CONTINUE.
      ENDIF.

    "Nicht existierender Customer
      LOOP AT lt_defcustomers ASSIGNING FIELD-SYMBOL(<defcustomer>).
      IF <defcustomer>-id = <booking>-customerid.
      lv_custexist = abap_true.
      ENDIF.
      ENDLOOP.

    "User hat nicht existierende Kunden angegeben
      IF lv_custexist = abap_false.
              message = NEW zcm_01_bookings(
          textid   = zcm_01_bookings=>co_noex_customer
          severity = zcm_01_bookings=>co_severity_error
        ).
        et_failed_key = VALUE #( BASE et_failed_key ( key = <booking>-key ) ).
        eo_message->add_cm( message ).
        CONTINUE.
      ENDIF.


IF <booking>-orderdate > <booking>-flightdate OR <booking>-orderdate > sy-datum.
              message = NEW zcm_01_bookings(
          textid   = zcm_01_bookings=>co_late_booking
          severity = zcm_01_bookings=>co_severity_error
        ).
        et_failed_key = VALUE #( BASE et_failed_key ( key = <booking>-key ) ).
        eo_message->add_cm( message ).
        CONTINUE.
ENDIF.

*IF NOT (  <booking>-flightclass = 'F' OR <booking>-flightclass = 'C' OR <booking>-flightclass = 'Y' OR <booking>-flightclass = '' ).
*              message = NEW zcm_01_bookings(
*          textid   = zcm_01_bookings=>co_wrongclass
*          severity = zcm_01_bookings=>co_severity_error
*        ).
*        et_failed_key = VALUE #( BASE et_failed_key ( key = <booking>-key ) ).
*        eo_message->add_cm( message ).
*        CONTINUE.
*ENDIF.

IF NOT (  <booking>-smoker = '' OR <booking>-smoker = 'X' ).
              message = NEW zcm_01_bookings(
          textid   = zcm_01_bookings=>co_smoker
          severity = zcm_01_bookings=>co_severity_error
        ).
        et_failed_key = VALUE #( BASE et_failed_key ( key = <booking>-key ) ).
        eo_message->add_cm( message ).
        CONTINUE.
ENDIF.


IF <booking>-luggageweight < 0 OR <booking>-amount < 0.
              message = NEW zcm_01_bookings(
          textid   = zcm_01_bookings=>co_neg_values
          severity = zcm_01_bookings=>co_severity_error
        ).
        et_failed_key = VALUE #( BASE et_failed_key ( key = <booking>-key ) ).
        eo_message->add_cm( message ).
        CONTINUE.
ENDIF.



      IF <booking>-carrierid = ''.


        message = NEW zcm_01_bookings(
          textid   = zcm_01_bookings=>co_incon_carrid
          severity = zcm_01_bookings=>co_severity_error
        ).
        et_failed_key = VALUE #( BASE et_failed_key ( key = <booking>-key ) ).
        eo_message->add_cm( message ).
        CONTINUE.
*      ELSE.
*      " Not cancelled
*        booking->cancelled = 'X'.
      ENDIF.

        " Success Nachricht erzeugen
*        message = NEW zcm_01_bookings(
*          textid   = zcm_01_bookings=>co_cancel_booking
*          severity = zcm_01_bookings=>co_severity_success
*        ).

        eo_message->add_cm( message ).

      " Daten zurückschreiben
*      io_modify->update(
*        EXPORTING
*          iv_node = is_ctx-node_key
*          iv_key  = booking->key
*          is_data = booking ).
    ENDLOOP.
  "Ende Copy


  ENDMETHOD.
ENDCLASS.
