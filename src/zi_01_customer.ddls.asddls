@AbapCatalog.sqlViewName: 'ZI01CUSTOMER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic Interface-View: Customer'
@VDM.viewType: #BASIC

define view ZI_01_CUSTOMER
  as select from scustom
{
  key id        as Id,
      name      as Name,
      form      as Form,
      street    as Street,
      postbox   as Postbox,
      postcode  as Postcode,
      city      as City,
      country   as Country,
      region    as Region,
      telephone as Telephone,
      custtype  as Custtype,
      discount  as Discount,
      langu     as Langu,
      email     as Email,
      webuser   as Webuser
}
