public class ReservationPageController {
    public List<Reservation__c> reservs{get;set;}
        
    
    public ReservationPageController(){
        reservs=[select City__c,Hotel__c,Room__c,ArrivalDate__c,DepartureDate__c,NumberOfGuest__c,ContactEmail__c from Reservation__c];
    } 
    
}