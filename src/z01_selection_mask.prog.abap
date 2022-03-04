*&---------------------------------------------------------------------*
*& Report Z01_SELECTION_MASK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_selection_mask.

DATA: lv_s_date TYPE s_date,
      lv_text TYPE String.

DATA: lv_carri TYPE c LENGTH 5,
      lv_conni TYPE c LENGTH 5.

DATA: lv_carid TYPE c LENGTH 5,
      lv_conid TYPE c LENGTH 5.

DATA: lv_ctry TYPE country_sp,
      lv_fldt TYPE s_date,
      lv_cfro TYPE s_city,
      lv_cto TYPE s_city,
      lv_amnt TYPE s_f_cur_pr.

DATA: lv_cntr TYPE country_sp,
      lv_cit TYPE s_city,
      lv_airp TYPE s_FROMAIRP.

Data: et_last_minute type zty_gt_last_minute.

CONSTANTS: co_last_minute TYPE string VALUE 'Last minute flights',
           co_flights     TYPE string VALUE 'Flight data',
           co_customer    TYPE string VALUE 'Customer Booking data',
           co_stat_bund   TYPE string VALUE 'Consolidation data flights',
           co_in_days     TYPE string VALUE 'in days'.

SELECTION-SCREEN BEGIN OF BLOCK case WITH FRAME TITLE TEXT-005.
    PARAMETERS: pa_fl_ch RADIOBUTTON GROUP rbg1 USER-COMMAND u1,
                pa_cu_ch RADIOBUTTON GROUP rbg1,
                pa_lm_ch RADIOBUTTON GROUP rbg1,
                pa_sb_ch RADIOBUTTON GROUP rbg1 DEFAULT 'X'.
  SELECTION-SCREEN END OF BLOCK case.

SELECTION-SCREEN BEGIN OF BLOCK flight_data WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: so_fldat FOR lv_s_date MODIF ID sc1.
  PARAMETERS:     pa_carri TYPE s_carr_id MODIF ID sc1,
                  pa_conni TYPE s_conn_id MODIF ID sc1.
SELECTION-SCREEN END OF BLOCK flight_data.

SELECTION-SCREEN BEGIN OF BLOCK customer_data WITH FRAME TITLE TEXT-002.
  PARAMETERS: pa_custo LIKE scustom-id MODIF ID sc2,
              pa_carid TYPE s_carr_id MODIF ID sc2,
              pa_conid TYPE s_conn_id MODIF ID sc2.
SELECTION-SCREEN END OF BLOCK customer_data.

SELECTION-SCREEN BEGIN OF BLOCK lastminute_data WITH FRAME TITLE TEXT-003.
"  SELECTION-SCREEN begin of line.
  PARAMETERS: pa_tole   TYPE int2 MODIF ID sc3.
  SELECTION-SCREEN COMMENT /1(20) co_days MODIF ID sc3 .
"  SELECTION-SCREEN end of line.
  PARAMETERS: pa_ctry   TYPE country_sp MODIF ID sc3,
              pa_cto    TYPE s_city MODIF ID sc3,
              pa_fldt   TYPE s_date MODIF ID sc3,
              pa_cfro   TYPE s_city MODIF ID sc3,
              pa_amnt   TYPE s_f_cur_pr MODIF ID sc3.
SELECTION-SCREEN END OF BLOCK lastminute_data.

SELECTION-SCREEN BEGIN OF BLOCK statbund_data WITH FRAME TITLE TEXT-004.
   PARAMETERS: pa_cntr  TYPE country_sp MODIF ID sc4,
               pa_cit  TYPE s_city MODIF ID sc4,
               pa_airp TYPE s_fromairp MODIF ID sc4.
SELECTION-SCREEN END OF BLOCK statbund_data.

*Case everythings empty Error
  IF pa_fl_ch EQ '' AND pa_cu_ch EQ '' AND pa_lm_ch EQ '' AND pa_sb_ch EQ ''.
    MESSAGE 'Please select a list' TYPE 'E'.

*Case Statistisches Bundesamt
  ELSEIF pa_sb_ch NE '' AND pa_fl_ch EQ '' AND pa_cu_ch EQ '' AND pa_lm_ch EQ ''.

    IF pa_cntr = ''.
      lv_cntr = '%'.
      ELSE.
        lv_cntr = pa_cntr.
      ENDIF.

    IF pa_cit = ''.
      lv_cit = '%'.
      ELSE.
        lv_cit = pa_cit.
      ENDIF.

    IF pa_airp = ''.
      lv_airp = '%'.
      ELSE.
        lv_airp = pa_airp.
        ENDIF.

      SELECT FROM sflight INNER JOIN spfli ON sflight~connid = spfli~connid
          FIELDS
            spfli~airpto,  COUNT( sflight~connid ) AS numberAirportTo
          WHERE spfli~cityto LIKE @lv_cit
            AND spfli~countryto LIKE @lv_cntr
            AND spfli~airpto LIKE @lv_airp
          GROUP BY spfli~airpto
          INTO TABLE @DATA(et_airport).

      SELECT spfli~countryto, COUNT( sflight~connid ) AS numberCountryTo
        FROM sflight INNER JOIN spfli ON sflight~connid = spfli~connid
        WHERE spfli~cityto LIKE @lv_cit
          AND spfli~countryto LIKE @lv_cntr
          AND spfli~airpto LIKE @lv_airp
        GROUP BY spfli~countryto
        INTO TABLE @DATA(et_country).

      SELECT spfli~cityto, COUNT( sflight~connid ) AS numberCityTo
        FROM sflight INNER JOIN spfli ON sflight~connid = spfli~connid
        WHERE spfli~cityto LIKE @lv_cit
          AND spfli~countryto LIKE @lv_cntr
          AND spfli~airpto LIKE @lv_airp
        GROUP BY spfli~cityto
        INTO TABLE @DATA(et_city).

*Case Show flights
  ELSEIF pa_fl_ch NE ''  AND pa_cu_ch EQ '' AND pa_lm_ch EQ '' AND pa_sb_ch EQ '' .
    "Insert flight FLANF 1 here for flights
     IF pa_carri = ''.
       lv_carri = '%'.
       ELSE.
         lv_carri = pa_carri.
         ENDIF.

      IF pa_conni = ''.
        lv_conni = '%'.
        ELSE.
          lv_conni = pa_conni.
          ENDIF.

    SELECT FROM spfli AS connection
        INNER JOIN sflight AS flight ON connection~connid = flight~connid
        INNER JOIN scarr AS carr ON carr~carrid = flight~carrid
          FIELDS carr~carrid, carr~carrname, connection~connid, flight~fldate, flight~planetype,
                 connection~deptime
        WHERE connection~carrid LIKE @lv_carri
          AND connection~connid LIKE @lv_conni
          AND flight~fldate BETWEEN @so_fldat-low AND @so_fldat-high
        ORDER BY flight~fldate ASCENDING
        INTO TABLE @DATA(et_flights).

*Case show customer bookings
  ELSEIF pa_fl_ch EQ '' AND pa_cu_ch NE '' AND pa_lm_ch EQ '' AND pa_sb_ch EQ ''.
    "Insert Customer Bookings here.
     IF pa_carid = ''.
       lv_carid = '%'.
       ELSE.
         lv_carid = pa_carid.
         ENDIF.

      IF pa_conid = ''.
        lv_conid = '%'.
        ELSE.
          lv_conid = pa_conid.
        ENDIF.

    SELECT FROM sbook FIELDS connid, carrid, bookid, customid, fldate, forcuram, forcurkey
      WHERE customid EQ @pa_custo
      AND carrid LIKE @lv_carid
      AND connid LIKE @lv_conid
      INTO TABLE @DATA(et_customer).

*Case show last minute flights
    ELSEIF pa_fl_ch EQ '' AND pa_cu_ch EQ '' AND pa_lm_ch NE '' AND pa_sb_ch EQ ''.

      DATA lv_tolerance TYPE s_date.

      IF pa_fldt IS INITIAL.
        lv_tolerance = sy-datum + pa_tole.
        ELSE.
          lv_tolerance = pa_fldt + pa_tole.
        ENDIF.

      IF pa_ctry IS INITIAL.
        lv_ctry = '%'.
        ELSE.
          lv_ctry = pa_ctry.
          ENDIF.

      IF pa_cfro IS INITIAL.
        lv_cfro = '%'.
        ELSE.
          lv_cfro = pa_cfro.
          ENDIF.

       IF pa_cto IS INITIAL.
         lv_cto = '%'.
          ELSE.
            lv_cto = pa_cto.
          ENDIF.

       IF pa_amnt IS INITIAL.
         lv_amnt = 1000000.
         ELSE.
           lv_amnt = pa_amnt.
           ENDIF.

       IF pa_ctry IS INITIAL.
         lv_ctry = '%'.
         ELSE.
           lv_ctry = pa_ctry.
           ENDIF.

    "Insert last minute flights
    SELECT sflight~connid, sflight~carrid, sflight~fldate, spfli~deptime, spfli~arrtime, spfli~period, spfli~countryfr,
      spfli~cityfrom, spfli~countryto, spfli~cityto, sflight~price , sflight~currency,
      sflight~seatsmax - sflight~seatsocc AS Available
    FROM sflight JOIN spfli ON sflight~connid = spfli~connid
      WHERE sflight~fldate > @pa_fldt               AND
         sflight~fldate <= @lv_tolerance            AND
         sflight~seatsmax - sflight~seatsocc > 0    AND
         spfli~cityfrom LIKE @lv_cfro               AND
         spfli~cityto LIKE @lv_cto                  AND
         sflight~price <= @lv_amnt                  AND
         spfli~countryto LIKE @lv_ctry
         ORDER BY sflight~price ASCENDING
    INTO CORRESPONDING FIELDS OF table @et_last_minute.

    lv_text = co_last_minute.

  ELSE.
    MESSAGE 'Please check your Input fields' TYPE 'E'.

  ENDIF.

AT SELECTION-SCREEN OUTPUT.
  co_days = co_in_days.

LOOP AT SCREEN.
    IF pa_fl_ch NE ''.
        IF screen-name = 'SO_FLDAT-LOW'.
          screen-input = '1'.
          screen-required = '2'.
          ENDIF.

        IF screen-group1 = 'SC2' OR screen-group1 = 'SC3' OR Screen-group1 = 'SC4'.
          screen-active = '0'.
          ENDIF.
        ENDIF.

     IF pa_cu_ch NE ''.
          IF screen-name = 'PA_CUSTO'.
           screen-input = '1'.
           screen-required = '2'.
          ENDIF.

          IF screen-group1 = 'SC1' OR screen-group1 = 'SC3' OR Screen-group1 = 'SC4'.
          screen-active = '0'.
          ENDIF.
       ENDIF.

     IF pa_lm_ch NE ''.
          IF screen-name = 'PA_TOLE'.
           screen-input = '1'.
           screen-required = '2'.
          ENDIF.

          IF screen-group1 = 'SC1' OR screen-group1 = 'SC2' OR Screen-group1 = 'SC4'.
          screen-active = '0'.
          ENDIF.
       ENDIF.

     IF pa_sb_ch NE ''.
          IF screen-group1 = 'SC1' OR screen-group1 = 'SC2' OR screen-group1 = 'SC3'.
          screen-active = '0'.
          ENDIF.
       ENDIF.

    MODIFY SCREEN.
  ENDLOOP.

AT SELECTION-SCREEN ON pa_custo.
  IF sy-ucomm = 'ONLI'.
    IF pa_custo IS INITIAL AND pa_cu_ch IS NOT INITIAL.
      MESSAGE e055(00).
    ENDIF.
  ENDIF.

AT SELECTION-SCREEN ON so_fldat.
  IF sy-ucomm = 'ONLI'.
    IF so_fldat-low IS INITIAL AND pa_fl_ch IS NOT INITIAL.
        MESSAGE e055(00).
        ENDIF.
     ENDIF.

AT SELECTION-SCREEN ON pa_tole.
  IF sy-ucomm = 'ONLI'.
    IF pa_tole IS INITIAL AND pa_lm_ch IS NOT INITIAL.
        MESSAGE e055(00).
        ENDIF.
     ENDIF.

START-OF-SELECTION.
  DATA(lo_table) = NEW z01_alv( ).

IF pa_fl_ch IS NOT INITIAL.
TRY.

  lo_table->generatealv(
    EXPORTING
    im_text  = co_flights
    CHANGING
      im_table = et_flights
   ).

  CATCH cx_salv_msg. " ALV: General Error Class with Message
    ENDTRY.

ELSEIF pa_cu_ch IS NOT INITIAL.
TRY.

  lo_table->generatealv(
    EXPORTING
    im_text  = co_customer
    CHANGING
      im_table = et_customer
   ).

  CATCH cx_salv_msg. " ALV: General Error Class with Message
    ENDTRY.

ELSEIF pa_lm_ch IS NOT INITIAL.

TRY.

  lo_table->generate_color_alv(
    CHANGING
      it_table = et_last_minute                 " Last minute offers
  ).
*  CATCH cx_salv_msg. " ALV: General Error Class with Message

  CATCH cx_salv_msg. " ALV: General Error Class with Message
    ENDTRY.

ELSEIF pa_sb_ch IS NOT INITIAL.
TRY.

  lo_table->generate_split_alv(
    EXPORTING
      iv_text1   = 'Flights at Airport'
      iv_text2   = 'Flights at Country'
      iv_text3   = 'Flights at City'
    CHANGING
      it_table1 = et_airport
      it_table2 = et_country
      it_table3 = et_city
  ).
*  CATCH cx_salv_msg. " ALV: General Error Class with Message

  CATCH cx_salv_msg. " ALV: General Error Class with Message
    ENDTRY.
 ENDIF.
