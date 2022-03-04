@AbapCatalog.sqlViewName: 'ZI01BOOKINGTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional Interface-View: Booking'

@VDM.viewType: #TRANSACTIONAL
@ObjectModel: {
    writeActivePersistence: 'zv01booking', //Mapping View

    representativeKey: 'BookingID',
    semanticKey: ['BookingID'],

    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

define view ZI_01_BOOKINGTP
  as select from ZI_01_Booking
  association [1] to ZI_01_FlightTP   as _Flight   on  _Flight.CarrierID    = ZI_01_Booking.CarrierID
                                                   and _Flight.ConnectionID = ZI_01_Booking.ConnectionID
                                                   and _Flight.FlightDate   = ZI_01_Booking.FlightDate
  association [1] to ZI_01_CUSTOMERTP as _Customer on  _Customer.Id = ZI_01_Booking.CustomerID
{
  key CarrierID,
  key ConnectionID,
  key FlightDate,
  key BookingID,
      @ObjectModel.mandatory: true
      @Consumption.filter: { mandatory: true }
      CustomerID,
      CustomerType,
      Smoker,
      case Smoker
      when ''  then 3
      when 'X' then 1
      end      as smoking,
      Luggageweight,
      WeightUnit,
      Invoice,
      case FlightClass
           when 'Y' then 'Economy'
           when 'C' then 'Business'
           when 'F' then 'First'
           else ''
           end as FlightClass,
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

      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _Flight,
      _Customer
}
where
  Cancelled <> 'X'
