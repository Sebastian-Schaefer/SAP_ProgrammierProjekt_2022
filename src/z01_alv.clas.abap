class Z01_ALV definition
  public
  final
  create public .

public section.

  methods GENERATEALV
    importing
      !IM_TEXT type STRING
    changing
      !IM_TABLE type ANY TABLE
    raising
      CX_SALV_MSG .
  methods GENERATE_SPLIT_ALV
    importing
      !IV_TEXT1 type TEXT70
      !IV_TEXT2 type TEXT70
      !IV_TEXT3 type TEXT70
    changing
      !IT_TABLE1 type ANY TABLE
      !IT_TABLE2 type ANY TABLE
      !IT_TABLE3 type ANY TABLE optional
    raising
      CX_SALV_MSG .
  methods GENERATE_COLOR_ALV
    changing
      !IT_TABLE type ZTY_GT_LAST_MINUTE
    raising
      CX_SALV_MSG
      CX_SALV_DATA_ERROR
      CX_SALV_NOT_FOUND .
protected section.
private section.
ENDCLASS.



CLASS Z01_ALV IMPLEMENTATION.


  method GENERATEALV.

    FIELD-SYMBOLS <table> type any.
    assign im_table to <table>.

* ALV-Gitter-Objekt erzeugen
  DATA(o_alv) = NEW cl_gui_alv_grid( i_parent      = cl_gui_container=>default_screen " in default container einbetten
                                     i_appl_events = abap_true ).                     " Ereignisse als Applikationsevents registrieren

* Feldkatalog automatisch durch SALV-Objekte erstellen lassen
  DATA: o_salv TYPE REF TO cl_salv_table.

  cl_salv_table=>factory( IMPORTING
                            r_salv_table = o_salv
                          CHANGING
                            t_table      = <table> ).

  DATA(it_fcat) = cl_salv_controller_metadata=>get_lvc_fieldcatalog( r_columns      = o_salv->get_columns( )
                                                                     r_aggregations = o_salv->get_aggregations( ) ).

* Layout des ALV setzen
  DATA(lv_layout) = VALUE lvc_s_layo( zebra      = abap_true             " ALV-Control: Alternierende Zeilenfarbe (Zebramuster)
                                      cwidth_opt = 'A'                   " ALV-Control: Spaltenbreite optimieren
                                      grid_title = im_text ). " ALV-Control: Text der Titelzeile

* ALV anzeigen
  o_alv->set_table_for_first_display( EXPORTING
                                        i_bypassing_buffer = abap_false  " Puffer ausschalten
                                        i_save             = 'A'         " Anzeigevariante sichern
                                        is_layout          = lv_layout   " Layout
                                      CHANGING
                                        it_fieldcatalog    = it_fcat     " Feldkatalog
                                        it_outtab          = <tablE> ). " Ausgabetabelle

* Focus auf ALV setzen
  cl_gui_alv_grid=>set_focus( control = o_alv ).

* leere SAP-Toolbar ausblenden
*  cl_abap_list_layout=>suppress_toolbar( ).

* erzwingen von cl_gui_container=>default_screen
  WRITE: space.

  endmethod.


  METHOD generate_color_alv.

DATA: ls_cellcol TYPE lvc_s_scol.

CONSTANTS: BEGIN OF gcs_color,
           col TYPE lvc_col VALUE 5, "steht hier für Grün
           int TYPE lvc_int VALUE 0,
           inv TYPE lvc_inv VALUE 0,
           END OF gcs_color.

 LOOP AT it_table ASSIGNING FIELD-SYMBOL(<fs>).

IF <fs>-available <= 10.
  <fs>-cellcol = 'C600'.
  elseif <fs>-available <= 15 and <fs>-available > 10 .
  <fs>-cellcol = 'C300'.
  elseif <fs>-available > 15.
  <fs>-cellcol = 'C500'.
ENDIF.
ENDLOOP.

FIELD-SYMBOLS <table> TYPE any.
    ASSIGN it_table TO <table>.

* ALV-Gitter-Objekt erzeugen
  DATA(o_alv) = NEW cl_gui_alv_grid( i_parent      = cl_gui_container=>default_screen " in default container einbetten
                                     i_appl_events = abap_true
                                     ).                     " Ereignisse als Applikationsevents registrieren

* Feldkatalog automatisch durch SALV-Objekte erstellen lassen
  DATA: o_salv TYPE REF TO cl_salv_table.

  cl_salv_table=>factory( IMPORTING
                            r_salv_table = o_salv
                          CHANGING
                            t_table      = <table> ).


  DATA(it_fcat) = cl_salv_controller_metadata=>get_lvc_fieldcatalog( r_columns      = o_salv->get_columns( )
                                                                     r_aggregations = o_salv->get_aggregations( )
                                                                     ).

try.
*o_salv->get_columns( )->set_color_column( value = 'CELLCOL' ).

*o_salv->get_columns( )->get_column( columnname = 'AVAILABLE' )->set_short_text( 'Avlb' ).
*o_salv->get_columns( )->get_column( columnname = 'AVAILABLE' )->set_optimized( ).
*o_salv->get_columns( )->get_column( columnname = 'AVAILABLE' )->set_medium_text( 'Available' ).
*o_salv->get_columns( )->get_column( columnname = 'AVAILABLE' )->set_long_text( 'Available' ).

catch cx_salv_msg.

endtry.
" ALV: General Error Class (Checked in Syntax Check)

  loop at it_fcat ASSIGNING FIELD-SYMBOL(<fc>).
    if <fc>-fieldname = 'AVAILABLE'.
    <fc>-reptext = 'Available'.
    <fc>-coltext = 'Available'.
    <fc>-outputlen = 10 .
    <fc>-col_opt = 'X'.
    endif.
    endloop.

* Layout des ALV setzen
  DATA(lv_layout) = VALUE lvc_s_layo( zebra      = abap_true             " ALV-Control: Alternierende Zeilenfarbe (Zebramuster)
                                      cwidth_opt = 'A'                   " ALV-Control: Spaltenbreite optimieren
                                      grid_title = 'Last minute flights'
                                      info_fname = 'CELLCOL'

                                                ). " ALV-Control: Text der Titelzeile

* ALV anzeigen
  o_alv->set_table_for_first_display( EXPORTING
                                        i_bypassing_buffer = abap_false  " Puffer ausschalten
                                        i_save             = 'A'         " Anzeigevariante sichern
                                        is_layout          = lv_layout   " Layout

                                      CHANGING
                                        it_fieldcatalog    = it_fcat     " Feldkatalog
                                        it_outtab          = <tablE> ). " Ausgabetabelle

* Focus auf ALV setzen
  cl_gui_alv_grid=>set_focus( control = o_alv ).

* leere SAP-Toolbar ausblenden
*  cl_abap_list_layout=>suppress_toolbar( ).

* erzwingen von cl_gui_container=>default_screen
  WRITE: space.

  ENDMETHOD.


  method GENERATE_SPLIT_ALV.

DATA: o_splitter_main TYPE REF TO cl_gui_splitter_container.
* Split Container upper
DATA: o_container_o   TYPE REF TO cl_gui_container.
* Split Container middle
DATA: o_container_m   TYPE REF TO cl_gui_container.
* Split Container under
DATA: o_container_u   TYPE REF TO cl_gui_container.

*Create Splitter main
o_splitter_main = NEW #( parent                  = cl_gui_container=>default_screen
                         no_autodef_progid_dynnr = abap_true       " wichtig
                         rows                    = 1
                         columns                 = 3 ).

o_splitter_main->set_row_height( id = 1 height = 40 ).

o_container_o = o_splitter_main->get_container( row = 1 column = 1 ).
o_container_u = o_splitter_main->get_container( row = 1 column = 2 ).
o_container_m = o_splitter_main->get_container( row = 1 column = 3 ).

DATA: o_salv_o TYPE REF TO cl_salv_table.

cl_salv_table=>factory( EXPORTING
                          r_container  = o_container_o
                        IMPORTING
                          r_salv_table = o_salv_o
                        CHANGING
                          t_table      = it_table1 ).

o_salv_o->get_functions( )->set_all( abap_true ).
o_salv_o->get_columns( )->set_optimize( abap_true ).
o_salv_o->get_display_settings( )->set_list_header( iv_text1 ).
o_salv_o->get_display_settings( )->set_striped_pattern( abap_true ).
o_salv_o->get_selections( )->set_selection_mode( if_salv_c_selection_mode=>row_column ).

* Spaltenüberschriften: technischer Name und Beschreibungstexte
LOOP AT o_salv_o->get_columns( )->get( ) ASSIGNING FIELD-SYMBOL(<so>).
  DATA(o_col_o) = <so>-r_column.
  o_col_o->set_short_text( || ).
  o_col_o->set_medium_text( || ).
  o_col_o->set_long_text( |{ o_col_o->get_columnname( ) }| ).
ENDLOOP.

* SALV-Grid anzeigen
o_salv_o->display( ).

DATA: o_salv_m TYPE REF TO cl_salv_table.

cl_salv_table=>factory( EXPORTING
                          r_container  = o_container_m
                        IMPORTING
                          r_salv_table = o_salv_m
                        CHANGING
                          t_table      = it_table2 ).

o_salv_m->get_functions( )->set_all( abap_true ).
o_salv_m->get_columns( )->set_optimize( abap_true ).
o_salv_m->get_display_settings( )->set_list_header( iv_text2 ).
o_salv_m->get_display_settings( )->set_striped_pattern( abap_true ).
o_salv_m->get_selections( )->set_selection_mode( if_salv_c_selection_mode=>row_column ).

* Spaltenüberschriften: technischer Name und Beschreibungstexte
LOOP AT o_salv_m->get_columns( )->get( ) ASSIGNING FIELD-SYMBOL(<sm>).
  DATA(o_col_m) = <sm>-r_column.
  o_col_m->set_short_text( || ).
  o_col_m->set_medium_text( || ).
  o_col_m->set_long_text( |{ o_col_m->get_columnname( ) }| ).
ENDLOOP.

* SALV-Grid anzeigen
o_salv_m->display( ).

* SALV-Table unten mit Flügen
DATA: o_salv_u TYPE REF TO cl_salv_table.

cl_salv_table=>factory( EXPORTING
                          r_container  = o_container_u
                        IMPORTING
                          r_salv_table = o_salv_u
                        CHANGING
                          t_table      = it_table3 ).

* Grundeinstellungen
o_salv_u->get_functions( )->set_all( abap_true ).
o_salv_u->get_columns( )->set_optimize( abap_true ).
o_salv_u->get_display_settings( )->set_list_header( iv_text3 ).
o_salv_u->get_display_settings( )->set_striped_pattern( abap_true ).
o_salv_u->get_selections( )->set_selection_mode( if_salv_c_selection_mode=>row_column ).

* Spaltenüberschriften: technischer Name und Beschreibungstexte
LOOP AT o_salv_u->get_columns( )->get( ) ASSIGNING FIELD-SYMBOL(<su>).
  DATA(o_col_u) = <su>-r_column.
  o_col_u->set_short_text( || ).
  o_col_u->set_medium_text( || ).
  o_col_u->set_long_text( |{ o_col_u->get_columnname( ) }| ).
ENDLOOP.

* SALV-Grid anzeigen
o_salv_u->display( ).

* leere Toolbar ausblenden
cl_abap_list_layout=>suppress_toolbar( ).

* Erzwingen von cl_gui_container=>default_screen
WRITE: space.

  endmethod.
ENDCLASS.
