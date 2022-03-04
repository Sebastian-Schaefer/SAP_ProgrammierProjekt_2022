@AbapCatalog.sqlViewName: 'ZI01BOOOKING'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic Interface View Project'
@VDM.viewType: #BASIC

define view ZI_01_Booking
  as select from sbook
{
  key carrid     as CarrierID,
  key connid     as ConnectionID,
  key fldate     as FlightDate,
  key bookid     as BookingID,
      customid   as CustomerID,
      custtype   as CustomerType,
      smoker     as Smoker,
      luggweight as Luggageweight,
      wunit      as WeightUnit,
      invoice    as Invoice,
      class      as FlightClass,
      forcuram   as Amount,
      forcurkey  as Forcurkey,
      loccuram   as LocalAmount,
      loccurkey  as LocalCurrency,
      order_date as OrderDate,
      counter    as Counter,
      agencynum  as AgencyNumber,
      cancelled  as Cancelled,
      reserved   as Reserved,
      passname   as PassName,
      passform   as PassForm,
      passbirth  as PassBirth

}
