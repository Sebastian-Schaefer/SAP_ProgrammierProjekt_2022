@AbapCatalog.sqlViewName: 'ZI01CUSTOMERTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional Interface-View: Customer'

@VDM.viewType: #TRANSACTIONAL
@ObjectModel: {
    writeActivePersistence: 'scustom', //Mapping View

    representativeKey: 'Id',
    semanticKey: ['Id']
}

define view ZI_01_CUSTOMERTP
  as select from ZI_01_CUSTOMER
  association [*] to ZI_01_BOOKINGTP as _Booking on _Booking.CustomerID = ZI_01_CUSTOMER.Id
{
  key Id,
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

      _Booking
}
