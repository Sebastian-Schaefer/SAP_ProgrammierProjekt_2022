CLASS zcl_i_d_bookingnumber DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_d_supercl_simple
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.

  METHODS /bobf/if_frw_determination~execute
    REDEFINITION .
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_i_d_bookingnumber IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.

  DATA lt_zi_01_bookingtp TYPE zti01_bookingtp.

*Get booking data
	io_read->retrieve(
    EXPORTING
      iv_node        = zif_i_01_flighttp_c=>sc_node-zi_01_bookingtp
      it_key         = it_key
    IMPORTING
      et_data        = lt_zi_01_bookingtp
      ).

  LOOP AT lt_zi_01_bookingtp REFERENCE INTO DATA(lr_booking).

*Select all bookings
      SELECT * FROM sbook INTO TABLE @DATA(lt_bookings).
      SORT lt_bookings DESCENDING BY bookid.

    DATA(lv_count) = 1.

*Find out highest booking ID
    WHILE sy-subrc EQ 0.
        READ TABLE lt_bookings ASSIGNING FIELD-SYMBOL(<fs>) WITH KEY bookid = lv_count.
        lv_count += lv_count.
    ENDWHILE.

    IF <fs> IS ASSIGNED.
    lr_booking->bookingid = <fs>-bookid + 1.
    ENDIF.

*Update Booking ID in io_modify
      io_modify->update(
        EXPORTING
          iv_node           = zif_i_01_flighttp_c=>sc_node-zi_01_bookingtp
          iv_key            = lr_booking->key
          is_data           = lr_booking
          it_changed_fields = VALUE #( ( zif_i_01_flighttp_c=>sc_node_attribute-zi_01_bookingtp-bookingid  ) )
      ).


      ENDLOOP.
  ENDMETHOD.
ENDCLASS.
