*&---------------------------------------------------------------------*
*& Report ZFANF03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFANF03.

PARAMETERS lv_range type i.
PARAMETERS lv_from type S_FROM_CIT.
PARAMETERS lv_to type S_TO_CITY.
PARAMETERS lv_price type S_PRICE.

DATA lastMinute type sy-datum.

lastMinute = sy-datum + 20.

"DATA ev_table type table of sflight.


*SELECT *
*  FROM SFLIGHT
*  INTO TABLE ev_table.
*
*  if sy-subrc <> 0.
*    WRITE 'Nicht erfolgreich'.
*    ENDIF.


 "Ausgabe

    START-OF-SELECTION.

*SELECT SPFLI~carrid SPFLI~connid SPFLI~cityfrom scarr~carrname
*  FROM SPFLI JOIN SCARR ON SPFLI~carrid = SCARR~carrid "standardmäßig ein INNER JOIN, Alternativ ein LEFT JOIN
*  INTO CORRESPONDING FIELDS OF TABLE gt_joincarrid "muss entsprechende Struktur haben (siehe SELECT)
*  WHERE SPFLI~carrid = 'LH' OR SPFLI~carrid = 'AA'. "Hier darf nur die linke Tabelle genannt werden

* Daten holen
"Verbesserung:
"Ankunftsdatum evtl. nach Abflugdatum? Spalte einfügen mit +1
"Alles auf eine Währung umrechnen

  SELECT sflight~fldate, spfli~deptime, spfli~arrtime, spfli~period, spfli~countryfr, spfli~cityfrom, spfli~countryto, spfli~cityto, sflight~price, sflight~currency, sflight~seatsmax - sflight~seatsocc as Available

    FROM sflight JOIN spfli ON sflight~connid = SPFLI~connid
   WHERE sflight~fldate > @sy-datum     and
         sflight~fldate <= @lastMinute  and
         sflight~seatsmax - sflight~seatsocc > 0 and
         spfli~cityfrom = @lv_from      and
         spfli~cityto = @lv_to          and
         sflight~price <= @lv_price
    ORDER BY sflight~price ASCENDING
    INTO TABLE @DATA(ev_table)
    .

* ALV-Gitter-Objekt erzeugen
  DATA(o_alv) = NEW cl_gui_alv_grid( i_parent      = cl_gui_container=>default_screen " in default container einbetten
                                     i_appl_events = abap_true ).                     " Ereignisse als Applikationsevents registrieren

* Feldkatalog automatisch durch SALV-Objekte erstellen lassen
  DATA: o_salv TYPE REF TO cl_salv_table.

  cl_salv_table=>factory( IMPORTING
                            r_salv_table = o_salv
                          CHANGING
                            t_table      = ev_table ).

  DATA(it_fcat) = cl_salv_controller_metadata=>get_lvc_fieldcatalog( r_columns      = o_salv->get_columns( )
                                                                     r_aggregations = o_salv->get_aggregations( ) ).

* Layout des ALV setzen
  DATA(lv_layout) = VALUE lvc_s_layo( zebra      = abap_true             " ALV-Control: Alternierende Zeilenfarbe (Zebramuster)
                                      cwidth_opt = 'A'                   " ALV-Control: Spaltenbreite optimieren
                                      grid_title = 'Flugverbindungen' ). " ALV-Control: Text der Titelzeile

* ALV anzeigen
  o_alv->set_table_for_first_display( EXPORTING
                                        i_bypassing_buffer = abap_false  " Puffer ausschalten
                                        i_save             = 'A'         " Anzeigevariante sichern
                                        is_layout          = lv_layout   " Layout
                                      CHANGING
                                        it_fieldcatalog    = it_fcat     " Feldkatalog
                                        it_outtab          = ev_table ). " Ausgabetabelle

* Focus auf ALV setzen
  cl_gui_alv_grid=>set_focus( control = o_alv ).

* leere SAP-Toolbar ausblenden
  cl_abap_list_layout=>suppress_toolbar( ).

* erzwingen von cl_gui_container=>default_screen
  WRITE: space.
