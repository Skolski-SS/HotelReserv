public class PreReservationPageController {
    
    public List<PreReservation__c> prereservs{get;set;}
    
    public PreReservationPageController(){ 
        prereservs=[select City__c,Hotel__c,Room__c,ChekinDate__c,ChekoutDate__c,Count__c,Email__c from PreReservation__c];
    }
    
}