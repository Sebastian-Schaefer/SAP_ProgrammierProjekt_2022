@AbapCatalog.sqlViewName: 'ZC01BOOKINGTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional Consumption-View: Booking'

@VDM.viewType: #CONSUMPTION
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel: {
    transactionalProcessingDelegated: true,
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

define view ZC_01_BOOKINGTP
  as select from ZI_01_BOOKINGTP
  association [1]    to ZC_01_FLIGHTTP     as _Flight       on  _Flight.CarrierID    = ZI_01_BOOKINGTP.CarrierID
                                                            and _Flight.ConnectionID = ZI_01_BOOKINGTP.ConnectionID
                                                            and _Flight.FlightDate   = ZI_01_BOOKINGTP.FlightDate
  association [1]    to ZC_01_CUSTOMERTP   as _Customer     on  _Customer.Id = ZI_01_BOOKINGTP.CustomerID
  association [1..1] to ZC_01_CARRIERVH    as _Carrier      on  _Carrier.Carrid = ZI_01_BOOKINGTP.CarrierID
  association [1]    to ZC_01_CUSTOMERVH   as _CustomerVH   on  _CustomerVH.Id = ZI_01_BOOKINGTP.CustomerID
  association [*]    to ZC_01_CONNECTIONVH as _ConnectionVH on  _ConnectionVH.Connid = ZI_01_BOOKINGTP.ConnectionID
{
      @Consumption.valueHelp: '_Carrier'
  key CarrierID,
      @Consumption.valueHelp: '_ConnectionVH'
  key ConnectionID,
  key FlightDate,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key BookingID,
      @ObjectModel.mandatory: true
      @Consumption.filter: { mandatory: true }
      @Consumption.valueHelp: '_CustomerVH'
      CustomerID,
      CustomerType,
      Smoker,
      smoking,
      @Semantics.quantity.unitOfMeasure: 'WeightUnit'
      Luggageweight,
      @Semantics.unitOfMeasure: true
      WeightUnit,
      Invoice,
      FlightClass,
      Amount,
      Forcurkey,
      LocalAmount,
      LocalCurrency,
      OrderDate,
      Counter,
      AgencyNumber,
      Cancelled,
      Reserved,
      PassName,
      PassForm,
      PassBirth,
      /* Associations */
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _Flight,

      _Customer,
      _Carrier,
      _CustomerVH,
      _ConnectionVH
}
