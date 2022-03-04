*&---------------------------------------------------------------------*
*& Report z01_compare_flightdata
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_compare_flightdata.

"Eingabemaske:
" - Airline
" - Flugverbindungsnummer
" - Abflugdatum

PARAMETERS p_carrid TYPE s_carr_id OBLIGATORY.
PARAMETERS p_connid TYPE s_conn_id.
PARAMETERS p_fldate TYPE s_date.


"1. p_connid IS NOT INITIAL.
"1.1 [X] Flugverbindungsnummer [ ] Abflugdatum
IF p_connid IS NOT INITIAL.
  IF p_fldate IS INITIAL.

    SELECT FROM spfli AS connection
        INNER JOIN sflight AS flight ON connection~connid = flight~connid
        INNER JOIN scarr AS carr ON carr~carrid = flight~carrid
        FIELDS carr~carrname, flight~connid, flight~fldate, connection~deptime
        WHERE connection~carrid = @p_carrid AND connection~connid = @p_connid
        ORDER BY flight~fldate ASCENDING
        INTO TABLE @DATA(g_flights).

    "1.2 [X] Flugverbindungsnummer [X] Abflugdatum
  ELSEIF p_fldate IS NOT INITIAL.
    SELECT FROM spfli AS connection
        INNER JOIN sflight AS flight ON connection~connid = flight~connid
        INNER JOIN scarr AS carr ON carr~carrid = flight~carrid
        FIELDS carr~carrname, flight~connid, flight~fldate, connection~deptime
        WHERE connection~carrid = @p_carrid
        ORDER BY flight~fldate ASCENDING
        INTO TABLE @g_flights.
  ENDIF.

"2. p_connid IS INITIAL.
ELSE.
  "2.1 [ ] Flugverbindungsnummer [X] Abflugdatum
  IF p_fldate IS NOT INITIAL.
    SELECT FROM spfli AS connection
        INNER JOIN sflight AS flight ON connection~connid = flight~connid
        INNER JOIN scarr AS carr ON carr~carrid = flight~carrid
        FIELDS carr~carrname, flight~connid, flight~fldate, connection~deptime
        WHERE connection~carrid = @p_carrid
        ORDER BY flight~fldate ASCENDING
        INTO TABLE @g_flights.
  ELSE.

    "2.2 [ ] Flugverbindungsnummer [ ] Abflugdatum
    SELECT FROM spfli AS flying
        INNER JOIN sflight AS flight ON flying~connid = flight~connid
        INNER JOIN scarr AS carr ON carr~carrid = flight~carrid
        FIELDS carr~carrname, flight~connid,flight~fldate, flying~deptime
        WHERE flying~carrid = @p_carrid
        ORDER BY flight~fldate ASCENDING
        INTO TABLE @g_flights.
  ENDIF.
ENDIF.

"ALV
cl_salv_table=>factory(
  IMPORTING
    r_salv_table   = DATA(o_alv)
  CHANGING
    t_table        = g_flights
).

o_alv->display( ).
