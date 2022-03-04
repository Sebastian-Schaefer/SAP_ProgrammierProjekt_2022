@AbapCatalog.sqlViewName: 'ZC01CUSTOMERTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional Consumption-View: Customer'

@VDM.viewType: #CONSUMPTION
@Metadata.allowExtensions: true
@Search.searchable: true

define view ZC_01_CUSTOMERTP
  as select from ZI_01_CUSTOMERTP
  association [*] to ZC_01_BOOKINGTP as _Booking on _Booking.CustomerID = ZI_01_CUSTOMERTP.Id
{
  key Id,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Name,
      Form,
      Street,
      Postbox,
      Postcode,
      City,
      Country,
      Region,
      Telephone,
      Custtype,
      Discount,
      Langu,
      Email,
      Webuser,

      /* Associations */
      _Booking
}
