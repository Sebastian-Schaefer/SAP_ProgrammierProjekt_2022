CLASS z01_customer_bookings DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_gs_bookings,
             bookid    TYPE s_book_id,
             fldate    TYPE s_date,
             deptime   TYPE s_dep_time,
             arrtime   TYPE s_arr_time,
             connid    TYPE s_conn_id,
             carrid    TYPE s_carrid,
             carrname  TYPE s_carrname,
             planetype TYPE s_planetye,
             class     TYPE s_class,
             forcuram  TYPE s_f_cur_pr,
             forcurkey TYPE s_curr,
           END OF ty_gs_bookings.

    TYPES ty_gt_bookings TYPE STANDARD TABLE OF ty_gs_bookings WITH KEY bookid.

    DATA: e_bookings TYPE ty_gt_bookings.


    CLASS-METHODS get_bookings
      IMPORTING i_customer_id     TYPE scustom-id
      RETURNING VALUE(e_bookings) TYPE ty_gt_bookings.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z01_customer_bookings IMPLEMENTATION.
  METHOD get_bookings.

    "SELECT: INNER JOIN ON Tables: sbook, sflight, scarr and spfli
    SELECT FROM sbook AS booking
    INNER JOIN sflight AS flight ON booking~connid = flight~connid AND booking~fldate = flight~fldate
    INNER JOIN scarr AS carr ON carr~carrid = flight~carrid
    INNER JOIN spfli AS connection ON booking~connid = connection~connid AND booking~carrid = connection~carrid
    FIELDS booking~bookid, flight~carrid,carr~carrname, flight~connid,flight~planetype,
    flight~fldate, connection~deptime, connection~arrtime, booking~class, booking~forcuram, booking~forcurkey
    WHERE customid = @i_customer_id
    ORDER BY flight~fldate
    INTO CORRESPONDING FIELDS OF TABLE @e_bookings.
  ENDMETHOD.

ENDCLASS.
