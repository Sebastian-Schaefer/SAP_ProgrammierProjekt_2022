@AbapCatalog.sqlViewName: 'ZI01FLIGHTTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional Interface-View: Flights'

@VDM.viewType: #TRANSACTIONAL
@ObjectModel: {
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'zv01flight', //Mapping View

    semanticKey: ['CarrierID', 'ConnectionID', 'FlightDate'],
    representativeKey: 'FlightDate'
}

define view ZI_01_FlightTP
  as select from ZI_01_FLIGHT
    inner join   ZI_01_CONNECTION as Connection on  Connection.Carrid = ZI_01_FLIGHT.CarrierID
                                                and Connection.Connid = ZI_01_FLIGHT.ConnectionID
  association [*] to ZI_01_BOOKINGTP as _Bookings    on  _Bookings.CarrierID    = ZI_01_FLIGHT.CarrierID
                                                     and _Bookings.ConnectionID = ZI_01_FLIGHT.ConnectionID
                                                     and _Bookings.FlightDate   = ZI_01_FLIGHT.FlightDate
  association [1] to scarr           as _CarrierName on  _CarrierName.carrid = ZI_01_FLIGHT.CarrierID
{

  key ZI_01_FLIGHT.CarrierID,
  key ZI_01_FLIGHT.ConnectionID,
  key FlightDate,
      Price,
      Currency,
      Planetype,
      Seatsmax,
      Seatsoccupied,
      Connection.Countryfr,
      Connection.Cityfrom,
      Connection.Airpfrom,
      Connection.Countryto,
      Connection.Cityto,
      Connection.Airpto,
      Connection.Deptime,
      Connection.Arrtime,
      Connection.Period,

      //OccupancyRate in %
      division(Seatsoccupied * 100, Seatsmax, 2) as OccupancyRate,

      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Bookings,
      _CarrierName
}
where
  FlightDate > $session.system_date
