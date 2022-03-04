@AbapCatalog.sqlViewName: 'ZC01CONNVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help: Connection'
define view ZC_01_CONNECTIONVH
  as select from spfli
{

      @EndUserText.label: 'Carrier ID'
      @EndUserText.quickInfo: 'Carrier ID'
  key carrid   as Carrid,
      @EndUserText.label: 'Connection ID'
      @EndUserText.quickInfo: 'Connection ID'
  key connid   as Connid,
      @EndUserText.label: 'Airport From'
      @EndUserText.quickInfo: 'Airport From'
      airpfrom as Airpfrom,
      @EndUserText.label: 'Airport To'
      @EndUserText.quickInfo: 'Airport To'
      airpto   as Airpto
}
