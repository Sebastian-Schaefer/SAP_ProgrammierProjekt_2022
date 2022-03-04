CLASS zcm_01_bookings DEFINITION
  PUBLIC
    INHERITING FROM /bobf/cm_frw

  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.

CONSTANTS:
      BEGIN OF co_cancel_booking,
        msgid TYPE symsgid VALUE 'Z01BOOKING', "Referenz auf Message Class
        msgno TYPE symsgno VALUE '000',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_cancel_booking.

 CONSTANTS:
      BEGIN OF co_incon_carrid,
        msgid TYPE symsgid VALUE 'Z01BOOKING', "Referenz auf Message Class
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_incon_carrid.

       CONSTANTS:
      BEGIN OF co_incon_connid,
        msgid TYPE symsgid VALUE 'Z01BOOKING', "Referenz auf Message Class
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_incon_connid.

       CONSTANTS:
      BEGIN OF co_incon_flightdate,
        msgid TYPE symsgid VALUE 'Z01BOOKING', "Referenz auf Message Class
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_incon_flightdate.

       CONSTANTS:
      BEGIN OF co_noex_carrier,
        msgid TYPE symsgid VALUE 'Z01BOOKING', "Referenz auf Message Class
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_noex_carrier.

       CONSTANTS:
      BEGIN OF co_alex_booking,
        msgid TYPE symsgid VALUE 'Z01BOOKING', "Referenz auf Message Class
        msgno TYPE symsgno VALUE '006',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_alex_booking.

             CONSTANTS:
      BEGIN OF co_noex_customer,
        msgid TYPE symsgid VALUE 'Z01BOOKING', "Referenz auf Message Class
        msgno TYPE symsgno VALUE '007',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_noex_customer.

      CONSTANTS:
        BEGIN OF co_late_booking,
        msgid TYPE symsgid VALUE 'Z01BOOKING', "Referenz auf Message Class
        msgno TYPE symsgno VALUE '008',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_late_booking.

            CONSTANTS:
        BEGIN OF co_wrongclass,
        msgid TYPE symsgid VALUE 'Z01BOOKING', "Referenz auf Message Class
        msgno TYPE symsgno VALUE '009',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_wrongclass.

            CONSTANTS:
        BEGIN OF co_smoker,
        msgid TYPE symsgid VALUE 'Z01BOOKING', "Referenz auf Message Class
        msgno TYPE symsgno VALUE '010',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_smoker.

      CONSTANTS:
        BEGIN OF co_neg_values,
        msgid TYPE symsgid VALUE 'Z01BOOKING', "Referenz auf Message Class
        msgno TYPE symsgno VALUE '011',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_neg_values.

      CONSTANTS:
        BEGIN OF co_nav_flightd,
        msgid TYPE symsgid VALUE 'Z01BOOKING', "Referenz auf Message Class
        msgno TYPE symsgno VALUE '012',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_nav_flightd.

      CONSTANTS:
        BEGIN OF co_nav_carrier,
        msgid TYPE symsgid VALUE 'Z01BOOKING', "Referenz auf Message Class
        msgno TYPE symsgno VALUE '013',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_nav_carrier.

      CONSTANTS:
        BEGIN OF co_fullybooked,
        msgid TYPE symsgid VALUE 'Z01BOOKING', "Referenz auf Message Class
        msgno TYPE symsgno VALUE '014',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_fullybooked.

      DATA cancelled TYPE s_cancel.

    METHODS constructor
      IMPORTING
        !textid LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        !severity TYPE ty_message_severity OPTIONAL
        !symptom TYPE ty_message_symptom OPTIONAL
        !lifetime TYPE ty_message_lifetime DEFAULT co_lifetime_transition
        !ms_origin_location TYPE /bobf/s_frw_location OPTIONAL
        !mt_environment_location TYPE /bobf/t_frw_location OPTIONAL
        !mv_act_key TYPE /bobf/act_key OPTIONAL
        !mv_assoc_key TYPE /bobf/obm_assoc_key OPTIONAL
        !mv_bopf_location TYPE /bobf/conf_key OPTIONAL
        !mv_det_key TYPE /bobf/det_key OPTIONAL
        !mv_query_key TYPE /bobf/obm_query_key OPTIONAL
        !mv_val_key TYPE /bobf/val_key OPTIONAL
        i_cancelled TYPE s_cancel OPTIONAL .

PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcm_01_bookings IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor(
    textid = textid
    previous = previous
    severity = severity
    symptom = symptom
    lifetime = lifetime
    ms_origin_location = ms_origin_location
    mt_environment_location = mt_environment_location
    mv_act_key = mv_act_key
    mv_assoc_key = mv_assoc_key
    mv_bopf_location = mv_bopf_location
    mv_det_key = mv_det_key
    mv_query_key = mv_query_key
    mv_val_key = mv_val_key ).
    CLEAR me->textid.
    cancelled = i_cancelled.
        IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
