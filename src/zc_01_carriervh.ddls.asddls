@AbapCatalog.sqlViewName: 'ZC01CARRIERVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help: Carrier'
define view ZC_01_CARRIERVH
  as select from scarr
{
      @EndUserText.label: 'Carrier ID'
      @EndUserText.quickInfo: 'Carrier ID'
  key carrid   as Carrid,
      @EndUserText.label: 'Carrier Name'
      @EndUserText.quickInfo: 'Carrier Name'
      carrname as Carrname
}
