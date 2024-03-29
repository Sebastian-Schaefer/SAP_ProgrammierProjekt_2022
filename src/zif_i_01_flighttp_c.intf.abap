interface ZIF_I_01_FLIGHTTP_C
  public .


  interfaces /BOBF/IF_LIB_CONSTANTS .

  constants:
    BEGIN OF SC_ACTION,
      BEGIN OF ZI_01_BOOKINGTP,
 CANCEL_BOOKING_N               TYPE /BOBF/ACT_KEY VALUE '005056044E851EECA6C51DDF226CD9C1',
 CREATE_ZI_01_BOOKINGTP         TYPE /BOBF/ACT_KEY VALUE '005056044E851EECA6A845FA93D69BF5',
 DELETE_ZI_01_BOOKINGTP         TYPE /BOBF/ACT_KEY VALUE '005056044E851EECA6A845FA93D71BF5',
 SAVE_ZI_01_BOOKINGTP           TYPE /BOBF/ACT_KEY VALUE '005056044E851EECA6A845FA93D79BF5',
 UPDATE_ZI_01_BOOKINGTP         TYPE /BOBF/ACT_KEY VALUE '005056044E851EECA6A845FA93D6DBF5',
 VALIDATE_ZI_01_BOOKINGTP       TYPE /BOBF/ACT_KEY VALUE '005056044E851EECA6A845FA93D75BF5',
      END OF ZI_01_BOOKINGTP,
      BEGIN OF ZI_01_FLIGHTTP,
 CANCEL_BOOKING_01              TYPE /BOBF/ACT_KEY VALUE '005056044E851EECA6C2357496A42CF1',
 CREATE_ZI_01_FLIGHTTP          TYPE /BOBF/ACT_KEY VALUE '005056044E851EECA6A845FA93CA3BF5',
 DELETE_ZI_01_FLIGHTTP          TYPE /BOBF/ACT_KEY VALUE '005056044E851EECA6A845FA93CABBF5',
 LOCK_ZI_01_FLIGHTTP            TYPE /BOBF/ACT_KEY VALUE '005056044E851EECA6A845FA93C97BF5',
 SAVE_ZI_01_FLIGHTTP            TYPE /BOBF/ACT_KEY VALUE '005056044E851EECA6A845FA93CB3BF5',
 UNLOCK_ZI_01_FLIGHTTP          TYPE /BOBF/ACT_KEY VALUE '005056044E851EECA6A845FA93C9BBF5',
 UPDATE_ZI_01_FLIGHTTP          TYPE /BOBF/ACT_KEY VALUE '005056044E851EECA6A845FA93CA7BF5',
 VALIDATE_ZI_01_FLIGHTTP        TYPE /BOBF/ACT_KEY VALUE '005056044E851EECA6A845FA93CAFBF5',
      END OF ZI_01_FLIGHTTP,
    END OF SC_ACTION .
  constants:
    BEGIN OF SC_ACTION_ATTRIBUTE,
        BEGIN OF ZI_01_FLIGHTTP,
        BEGIN OF LOCK_ZI_01_FLIGHTTP,
 GENERIC                        TYPE STRING VALUE 'GENERIC',
 EDIT_MODE                      TYPE STRING VALUE 'EDIT_MODE',
 ALL_NONE                       TYPE STRING VALUE 'ALL_NONE',
 SCOPE                          TYPE STRING VALUE 'SCOPE',
 FORCE_INVALIDATION             TYPE STRING VALUE 'FORCE_INVALIDATION',
 LOCK_PARAMETER_BUFFER          TYPE STRING VALUE 'LOCK_PARAMETER_BUFFER',
 LEGACY_DAC_KEY                 TYPE STRING VALUE 'LEGACY_DAC_KEY',
        END OF LOCK_ZI_01_FLIGHTTP,
        BEGIN OF UNLOCK_ZI_01_FLIGHTTP,
 GENERIC                        TYPE STRING VALUE 'GENERIC',
 EDIT_MODE                      TYPE STRING VALUE 'EDIT_MODE',
 ALL_NONE                       TYPE STRING VALUE 'ALL_NONE',
 SCOPE                          TYPE STRING VALUE 'SCOPE',
 FORCE_INVALIDATION             TYPE STRING VALUE 'FORCE_INVALIDATION',
 LOCK_PARAMETER_BUFFER          TYPE STRING VALUE 'LOCK_PARAMETER_BUFFER',
 LEGACY_DAC_KEY                 TYPE STRING VALUE 'LEGACY_DAC_KEY',
        END OF UNLOCK_ZI_01_FLIGHTTP,
      END OF ZI_01_FLIGHTTP,
    END OF SC_ACTION_ATTRIBUTE .
  constants:
    BEGIN OF SC_ALTERNATIVE_KEY,
      BEGIN OF ZI_01_BOOKINGTP,
 DB_KEY                         TYPE /BOBF/OBM_ALTKEY_KEY VALUE '005056044E851EECA6A845FA93CD1BF5',
 PARENT_KEY                     TYPE /BOBF/OBM_ALTKEY_KEY VALUE '005056044E851EECA6A845FA93CD3BF5',
      END OF ZI_01_BOOKINGTP,
      BEGIN OF ZI_01_FLIGHTTP,
 DB_KEY                         TYPE /BOBF/OBM_ALTKEY_KEY VALUE '005056044E851EECA6A845FA93CCDBF5',
      END OF ZI_01_FLIGHTTP,
    END OF SC_ALTERNATIVE_KEY .
  constants:
    BEGIN OF SC_ASSOCIATION,
      BEGIN OF ZI_01_BOOKINGTP,
 MESSAGE                        TYPE /BOBF/OBM_ASSOC_KEY VALUE '005056044E851EECA6A845FA93D63BF5',
 PROPERTY                       TYPE /BOBF/OBM_ASSOC_KEY VALUE '005056044E851EECA6A845FA93D67BF5',
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '005056044E851EECA6A845FA93D7DBF5',
 TO_ROOT                        TYPE /BOBF/OBM_ASSOC_KEY VALUE '005056044E851EECA6A845FA93D7FBF5',
      END OF ZI_01_BOOKINGTP,
      BEGIN OF ZI_01_BOOKINGTP_MESSAGE,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '005056044E851EECA6A845FA93D81BF5',
      END OF ZI_01_BOOKINGTP_MESSAGE,
      BEGIN OF ZI_01_BOOKINGTP_PROPERTY,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '005056044E851EECA6A845FA93D83BF5',
      END OF ZI_01_BOOKINGTP_PROPERTY,
      BEGIN OF ZI_01_FLIGHTTP,
 LOCK                           TYPE /BOBF/OBM_ASSOC_KEY VALUE '005056044E851EECA6A845FA93C95BF5',
 MESSAGE                        TYPE /BOBF/OBM_ASSOC_KEY VALUE '005056044E851EECA6A845FA93C91BF5',
 PROPERTY                       TYPE /BOBF/OBM_ASSOC_KEY VALUE '005056044E851EECA6A845FA93CA1BF5',
 _BOOKINGS                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '005056044E851EECA6A845FA93D5DBF5',
      END OF ZI_01_FLIGHTTP,
      BEGIN OF ZI_01_FLIGHTTP_LOCK,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '005056044E851EECA6A845FA93CB9BF5',
      END OF ZI_01_FLIGHTTP_LOCK,
      BEGIN OF ZI_01_FLIGHTTP_MESSAGE,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '005056044E851EECA6A845FA93CB7BF5',
      END OF ZI_01_FLIGHTTP_MESSAGE,
      BEGIN OF ZI_01_FLIGHTTP_PROPERTY,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '005056044E851EECA6A845FA93CBBBF5',
      END OF ZI_01_FLIGHTTP_PROPERTY,
    END OF SC_ASSOCIATION .
  constants:
    BEGIN OF SC_ASSOCIATION_ATTRIBUTE,
      BEGIN OF ZI_01_BOOKINGTP,
        BEGIN OF PROPERTY,
 ALL_NODE_PROPERTY              TYPE STRING VALUE 'ALL_NODE_PROPERTY',
 ALL_NODE_ATTRIBUTE_PROPERTY    TYPE STRING VALUE 'ALL_NODE_ATTRIBUTE_PROPERTY',
 ALL_ASSOCIATION_PROPERTY       TYPE STRING VALUE 'ALL_ASSOCIATION_PROPERTY',
 ALL_ASSOCIATION_ATTRIBUTE_PROP TYPE STRING VALUE 'ALL_ASSOCIATION_ATTRIBUTE_PROP',
 ALL_ACTION_PROPERTY            TYPE STRING VALUE 'ALL_ACTION_PROPERTY',
 ALL_ACTION_ATTRIBUTE_PROPERTY  TYPE STRING VALUE 'ALL_ACTION_ATTRIBUTE_PROPERTY',
 ALL_QUERY_PROPERTY             TYPE STRING VALUE 'ALL_QUERY_PROPERTY',
 ALL_QUERY_ATTRIBUTE_PROPERTY   TYPE STRING VALUE 'ALL_QUERY_ATTRIBUTE_PROPERTY',
 ALL_SUBTREE_PROPERTY           TYPE STRING VALUE 'ALL_SUBTREE_PROPERTY',
        END OF PROPERTY,
      END OF ZI_01_BOOKINGTP,
      BEGIN OF ZI_01_FLIGHTTP,
        BEGIN OF PROPERTY,
 ALL_NODE_PROPERTY              TYPE STRING VALUE 'ALL_NODE_PROPERTY',
 ALL_NODE_ATTRIBUTE_PROPERTY    TYPE STRING VALUE 'ALL_NODE_ATTRIBUTE_PROPERTY',
 ALL_ASSOCIATION_PROPERTY       TYPE STRING VALUE 'ALL_ASSOCIATION_PROPERTY',
 ALL_ASSOCIATION_ATTRIBUTE_PROP TYPE STRING VALUE 'ALL_ASSOCIATION_ATTRIBUTE_PROP',
 ALL_ACTION_PROPERTY            TYPE STRING VALUE 'ALL_ACTION_PROPERTY',
 ALL_ACTION_ATTRIBUTE_PROPERTY  TYPE STRING VALUE 'ALL_ACTION_ATTRIBUTE_PROPERTY',
 ALL_QUERY_PROPERTY             TYPE STRING VALUE 'ALL_QUERY_PROPERTY',
 ALL_QUERY_ATTRIBUTE_PROPERTY   TYPE STRING VALUE 'ALL_QUERY_ATTRIBUTE_PROPERTY',
 ALL_SUBTREE_PROPERTY           TYPE STRING VALUE 'ALL_SUBTREE_PROPERTY',
        END OF PROPERTY,
      END OF ZI_01_FLIGHTTP,
    END OF SC_ASSOCIATION_ATTRIBUTE .
  constants:
    SC_BO_KEY  TYPE /BOBF/OBM_BO_KEY VALUE '005056044E851EECA6A845FA93C87BF5' .
  constants:
    SC_BO_NAME TYPE /BOBF/OBM_NAME VALUE 'ZI_01_FLIGHTTP' .
  constants:
    BEGIN OF SC_DETERMINATION,
      BEGIN OF ZI_01_BOOKINGTP,
 ACTION_AND_FIELD_CONTROL       TYPE /BOBF/DET_KEY VALUE '005056044E851EECA6A845FA93CD5BF5',
 BOOKINGNUMBER                  TYPE /BOBF/DET_KEY VALUE '005056044E851EECA6E24287C7C99469',
      END OF ZI_01_BOOKINGTP,
      BEGIN OF ZI_01_FLIGHTTP,
 ACTION_AND_FIELD_CONTROL       TYPE /BOBF/DET_KEY VALUE '005056044E851EECA6A845FA93CCFBF5',
      END OF ZI_01_FLIGHTTP,
    END OF SC_DETERMINATION .
  constants:
    BEGIN OF SC_GROUP,
 ZI_01_FLIGHTTP                 TYPE /BOBF/OBM_GROUP_KEY VALUE '005056044E851EECA6A845FA93D89BF5',
    END OF SC_GROUP .
  constants:
    SC_MODEL_VERSION TYPE /BOBF/CONF_VERSION VALUE '00000' .
  constants:
    BEGIN OF SC_NODE,
 ZI_01_BOOKINGTP                TYPE /BOBF/OBM_NODE_KEY VALUE '005056044E851EECA6A845FA93CC1BF5',
 ZI_01_BOOKINGTP_MESSAGE        TYPE /BOBF/OBM_NODE_KEY VALUE '005056044E851EECA6A845FA93D61BF5',
 ZI_01_BOOKINGTP_PROPERTY       TYPE /BOBF/OBM_NODE_KEY VALUE '005056044E851EECA6A845FA93D65BF5',
 ZI_01_FLIGHTTP                 TYPE /BOBF/OBM_NODE_KEY VALUE '005056044E851EECA6A845FA93C8BBF5',
 ZI_01_FLIGHTTP_LOCK            TYPE /BOBF/OBM_NODE_KEY VALUE '005056044E851EECA6A845FA93C93BF5',
 ZI_01_FLIGHTTP_MESSAGE         TYPE /BOBF/OBM_NODE_KEY VALUE '005056044E851EECA6A845FA93C8FBF5',
 ZI_01_FLIGHTTP_PROPERTY        TYPE /BOBF/OBM_NODE_KEY VALUE '005056044E851EECA6A845FA93C9FBF5',
    END OF SC_NODE .
  constants:
    BEGIN OF SC_NODE_ATTRIBUTE,
      BEGIN OF ZI_01_BOOKINGTP,
  NODE_DATA                      TYPE STRING VALUE 'NODE_DATA',
  CARRIERID                      TYPE STRING VALUE 'CARRIERID',
  CONNECTIONID                   TYPE STRING VALUE 'CONNECTIONID',
  FLIGHTDATE                     TYPE STRING VALUE 'FLIGHTDATE',
  BOOKINGID                      TYPE STRING VALUE 'BOOKINGID',
  CUSTOMERID                     TYPE STRING VALUE 'CUSTOMERID',
  CUSTOMERTYPE                   TYPE STRING VALUE 'CUSTOMERTYPE',
  SMOKER                         TYPE STRING VALUE 'SMOKER',
  LUGGAGEWEIGHT                  TYPE STRING VALUE 'LUGGAGEWEIGHT',
  WEIGHTUNIT                     TYPE STRING VALUE 'WEIGHTUNIT',
  INVOICE                        TYPE STRING VALUE 'INVOICE',
  FLIGHTCLASS                    TYPE STRING VALUE 'FLIGHTCLASS',
  AMOUNT                         TYPE STRING VALUE 'AMOUNT',
  FORCURKEY                      TYPE STRING VALUE 'FORCURKEY',
  LOCALAMOUNT                    TYPE STRING VALUE 'LOCALAMOUNT',
  LOCALCURRENCY                  TYPE STRING VALUE 'LOCALCURRENCY',
  ORDERDATE                      TYPE STRING VALUE 'ORDERDATE',
  COUNTER                        TYPE STRING VALUE 'COUNTER',
  AGENCYNUMBER                   TYPE STRING VALUE 'AGENCYNUMBER',
  CANCELLED                      TYPE STRING VALUE 'CANCELLED',
  RESERVED                       TYPE STRING VALUE 'RESERVED',
  PASSNAME                       TYPE STRING VALUE 'PASSNAME',
  PASSFORM                       TYPE STRING VALUE 'PASSFORM',
  PASSBIRTH                      TYPE STRING VALUE 'PASSBIRTH',
  SMOKING                        TYPE STRING VALUE 'SMOKING',
      END OF ZI_01_BOOKINGTP,
      BEGIN OF ZI_01_FLIGHTTP,
  NODE_DATA                      TYPE STRING VALUE 'NODE_DATA',
  CARRIERID                      TYPE STRING VALUE 'CARRIERID',
  CONNECTIONID                   TYPE STRING VALUE 'CONNECTIONID',
  FLIGHTDATE                     TYPE STRING VALUE 'FLIGHTDATE',
  PRICE                          TYPE STRING VALUE 'PRICE',
  CURRENCY                       TYPE STRING VALUE 'CURRENCY',
  PLANETYPE                      TYPE STRING VALUE 'PLANETYPE',
  SEATSMAX                       TYPE STRING VALUE 'SEATSMAX',
  SEATSOCCUPIED                  TYPE STRING VALUE 'SEATSOCCUPIED',
  COUNTRYFR                      TYPE STRING VALUE 'COUNTRYFR',
  CITYFROM                       TYPE STRING VALUE 'CITYFROM',
  AIRPFROM                       TYPE STRING VALUE 'AIRPFROM',
  COUNTRYTO                      TYPE STRING VALUE 'COUNTRYTO',
  CITYTO                         TYPE STRING VALUE 'CITYTO',
  AIRPTO                         TYPE STRING VALUE 'AIRPTO',
  DEPTIME                        TYPE STRING VALUE 'DEPTIME',
  ARRTIME                        TYPE STRING VALUE 'ARRTIME',
  PERIOD                         TYPE STRING VALUE 'PERIOD',
  OCCUPANCYRATE                  TYPE STRING VALUE 'OCCUPANCYRATE',
      END OF ZI_01_FLIGHTTP,
    END OF SC_NODE_ATTRIBUTE .
  constants:
    BEGIN OF SC_NODE_CATEGORY,
      BEGIN OF ZI_01_BOOKINGTP,
 ZI_01_BOOKINGTP                TYPE /BOBF/OBM_NODE_CAT_KEY VALUE '005056044E851EECA6A845FA93D5BBF5',
      END OF ZI_01_BOOKINGTP,
      BEGIN OF ZI_01_FLIGHTTP,
 ROOT                           TYPE /BOBF/OBM_NODE_CAT_KEY VALUE '005056044E851EECA6A845FA93C8DBF5',
      END OF ZI_01_FLIGHTTP,
    END OF SC_NODE_CATEGORY .
  constants:
    BEGIN OF SC_VALIDATION,
      BEGIN OF ZI_01_BOOKINGTP,
 ALTKEY_UNIQUENESS_CHECK        TYPE /BOBF/VAL_KEY VALUE '005056044E851EECA6A845FA93CDFBF5',
 CHECKBOOKINGCREATION_N         TYPE /BOBF/VAL_KEY VALUE '005056044E851EDCA6DA45D94877F2E6',
      END OF ZI_01_BOOKINGTP,
      BEGIN OF ZI_01_FLIGHTTP,
 ALTKEY_UNIQUENESS_CHECK        TYPE /BOBF/VAL_KEY VALUE '005056044E851EECA6A845FA93D0BBF5',
 CHECKBOOKINGCREATION           TYPE /BOBF/VAL_KEY VALUE '005056044E851EDCA6C8185B6F3CA5CA',
      END OF ZI_01_FLIGHTTP,
    END OF SC_VALIDATION .
endinterface.
