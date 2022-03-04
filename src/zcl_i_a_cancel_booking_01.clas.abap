class ZCL_I_A_CANCEL_BOOKING_01 definition
  public
  inheriting from /BOBF/CL_LIB_A_SUPERCL_SIMPLE
  final
  create public .

public section.

  methods /BOBF/IF_FRW_ACTION~EXECUTE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_I_A_CANCEL_BOOKING_01 IMPLEMENTATION.


  method /BOBF/IF_FRW_ACTION~EXECUTE.
  DATA bookings type ZTI01_BOOKINGTP.
  DATA message type ref to zcm_01_bookings.

      " Daten lesen
    io_read->retrieve(
      EXPORTING
        iv_node       = is_ctx-node_key
        it_key        = it_key
      IMPORTING
        eo_message    = eo_message
        et_data       = bookings
        et_failed_key = et_failed_key ).

    " Nachrichten-Container erstellen
    IF eo_message IS NOT BOUND.
      eo_message = /bobf/cl_frw_factory=>get_message( ).
    ENDIF.

    " Daten sequentiell durchlaufen
    LOOP AT bookings REFERENCE INTO DATA(booking).
      IF booking->cancelled = 'X'.
      " Already cancelled
      " Error Nachricht erzeugen
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Noch um Fall falls bereits storniert ist, kümmern
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*        message = NEW zcm_01_bookings(
*          textid   = zcm_fapp_booking=>co_cancel_failed_booking
*          severity = zcm_fapp_booking=>co_severity_error
*        ).
*        et_failed_key = VALUE #( BASE et_failed_key ( key = booking->key ) ).
*        eo_message->add_cm( message ).
*        CONTINUE.
      ELSE.
      " Not cancelled
        booking->cancelled = 'X'.
      ENDIF.

        " Success Nachricht erzeugen
        message = NEW zcm_01_bookings(
          textid   = zcm_01_bookings=>co_cancel_booking
          severity = zcm_01_bookings=>co_severity_success
        ).

        eo_message->add_cm( message ).

      " Daten zurückschreiben
      io_modify->update(
        EXPORTING
          iv_node = is_ctx-node_key
          iv_key  = booking->key
          is_data = booking ).
    ENDLOOP.


  endmethod.
ENDCLASS.
