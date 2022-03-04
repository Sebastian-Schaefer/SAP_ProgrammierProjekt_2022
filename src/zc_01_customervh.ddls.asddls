@AbapCatalog.sqlViewName: 'ZC01CUSTOMERVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help: Customer'
define view ZC_01_CUSTOMERVH
  as select from scustom
{

      @EndUserText.label: 'Customer ID'
      @EndUserText.quickInfo: 'Customer ID'
  key id   as Id,
      @EndUserText.label: 'Name'
      @EndUserText.quickInfo: 'Name'
      name as Name

}
