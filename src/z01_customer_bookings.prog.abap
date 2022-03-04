*&---------------------------------------------------------------------*
*& Report z01_customer_bookings
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_customer_bookings.

"Param: Customer Name - [Type: S_Customer -> Table: SCUSTOM]
PARAMETERS p_custid TYPE s_customer OBLIGATORY.

*"Tabellenstruktur erstellen
*TYPES: BEGIN OF ty_gs_bookings,
*         bookid    TYPE s_book_id,
*         carrname  TYPE s_carrname,
*         planetype TYPE s_planetye,
*         fldate    TYPE s_date,
*         deptime   TYPE s_dep_time,
*         arrtime   TYPE s_arr_time,
*         class     TYPE s_class,
*         forcuram  TYPE s_f_cur_pr,
*         forcurkey TYPE s_curr,
*         carrid    TYPE s_carrid,
*         connid    TYPE s_conn_id,
*       END OF ty_gs_bookings.
*
*"Tabellentyp
*TYPES ty_gt_bookings TYPE STANDARD TABLE OF ty_gs_bookings WITH KEY bookid.

"DATA g_bookings TYPE ty_gt_bookings.
DATA g_bookings TYPE z01_customer_bookings=>ty_gt_bookings.

"Tabelle befüllen
g_bookings = z01_customer_bookings=>get_bookings( p_custid ).


"Test ALV
cl_salv_table=>factory(
  IMPORTING
    r_salv_table   = DATA(o_alv)
  CHANGING
    t_table        = g_bookings
).

o_alv->display( ).
