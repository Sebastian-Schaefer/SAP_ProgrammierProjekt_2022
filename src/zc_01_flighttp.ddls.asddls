@AbapCatalog.sqlViewName: 'ZC01FLIGHTTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional Consumption-View: Flights'

@VDM.viewType: #CONSUMPTION
@OData.publish: true
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel: {
    transactionalProcessingDelegated: true
}

define view ZC_01_FLIGHTTP
  as select from ZI_01_FlightTP
  association [*] to ZC_01_BOOKINGTP as _Bookings    on  _Bookings.CarrierID    = ZI_01_FlightTP.CarrierID
                                                     and _Bookings.ConnectionID = ZI_01_FlightTP.ConnectionID
                                                     and _Bookings.FlightDate   = ZI_01_FlightTP.FlightDate
  association [1] to scarr           as _CarrierName on  _CarrierName.carrid = ZI_01_FlightTP.CarrierID
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key CarrierID,
  key ConnectionID,
  key FlightDate,
      _CarrierName.carrname,
      @Semantics.amount.currencyCode: 'Currency'
      Price,
      @Semantics.currencyCode: true
      Currency,
      Planetype,
      Seatsmax,
      Seatsoccupied,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Countryfr,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Cityfrom,
      Airpfrom,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Countryto,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Cityto,
      Airpto,
      Deptime,
      Arrtime,
      Period,
      OccupancyRate,

      /* Associations */
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Bookings,
      _CarrierName
}
