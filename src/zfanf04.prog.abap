*&---------------------------------------------------------------------*
*& Report ZFANF04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFANF04.

*select COUNT
*FROM sflight JOIN spfli ON sflight~connid = SPFLI~connid


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

*select spfli~countryfr, count( spfli~countryfr ) as numberCountryFrom , spfli~countryto, count( spfli~countryto ) as numberCountryTo
*FROM sflight JOIN spfli ON sflight~connid = SPFLI~connid
*    GROUP BY spfli~countryfr, spfli~countryto
*    INTO TABLE @DATA(ev_table)


"Amount of flights from country
*select spfli~countryfr, count( DISTINCT spfli~connid ) as numberCountryFrom", spfli~countryto, count( spfli~connid ) as numberCountryTo
*FROM sflight inner JOIN spfli ON sflight~connid = SPFLI~connid
*    GROUP BY spfli~countryfr ", spfli~countryto
*    INTO TABLE @DATA(ev_table)
*    .


"Amount of flights to country
*  select spfli~countryto, count( DISTINCT spfli~connid ) as numberCountryTo", spfli~countryto, count( spfli~connid ) as numberCountryTo
*FROM sflight inner JOIN spfli ON sflight~connid = SPFLI~connid
*    GROUP BY spfli~countryto ", spfli~countryto
*    INTO TABLE @DATA(ev_table)
*    .


*"Amount of flights from city
*  select spfli~cityfrom, count( DISTINCT spfli~connid ) as numberCityFrom", spfli~countryto, count( spfli~connid ) as numberCountryTo
*FROM sflight inner JOIN spfli ON sflight~connid = SPFLI~connid
*    GROUP BY spfli~cityfrom ", spfli~countryto
*    INTO TABLE @DATA(ev_table)
*.


"Amount of flights to city
*  select spfli~cityto, count( DISTINCT spfli~connid ) as numberCityTo", spfli~countryto, count( spfli~connid ) as numberCountryTo
*FROM sflight inner JOIN spfli ON sflight~connid = SPFLI~connid
*    GROUP BY spfli~cityto ", spfli~countryto
*    INTO TABLE @DATA(ev_table)
*.


"Amount of flights to city
*  select spfli~cityto, count( DISTINCT spfli~connid ) as numberCityTo", spfli~countryto, count( spfli~connid ) as numberCountryTo
*FROM sflight inner JOIN spfli ON sflight~connid = SPFLI~connid
*    GROUP BY spfli~cityto ", spfli~countryto
*    INTO TABLE @DATA(ev_table)
*.

"Amount of flights from airport
*  select spfli~AIRPFROM, count( DISTINCT spfli~connid ) as numberAirportFrom", spfli~countryto, count( spfli~connid ) as numberCountryTo
*FROM sflight inner JOIN spfli ON sflight~connid = SPFLI~connid
*    GROUP BY spfli~AIRPFROM ", spfli~countryto
*    INTO TABLE @DATA(ev_table)
*.

"Amount of flights to airport
  select spfli~AIRPTO, count( DISTINCT spfli~connid ) as numberAirportTo", spfli~countryto, count( spfli~connid ) as numberCountryTo
FROM sflight inner JOIN spfli ON sflight~connid = SPFLI~connid
    GROUP BY spfli~AIRPTO ", spfli~countryto
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
