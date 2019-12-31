public class EditReservPageController {
    public Reservation__c reserv{get; set;}
    public Room__c reservroom{get;set;}
    Public String reservid = System.currentPagereference().getParameters().get('reservroom');
    
    public EditReservPageController(){
        reserv = new Reservation__c();
        reserv= [SELECT id,City__c, Hotel__c, Room__c,ArrivalDate__c, DepartureDate__c, NumberOfGuest__c, ContactEmail__c FROM Reservation__c WHERE id=:reservid];
        reservroom= [SELECT id,City__c,Name, Hotel__c, IsBooked__c,
                     Alcohol__c, Internet__c, Sauna__c FROM Room__c WHERE id=:reserv.Room__c];
    }
    
    
    public Pagereference save(){        
        try {                      
            update reserv;
            update reservroom;
            PageReference pref=new PageReference('/apex/ReservationPage');
            pref.setRedirect(true);
            return pref;
        }catch (DMLException e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, '"Something went wrong !"'));
            return null;
        }       
        
    }    
    public Pagereference cancel(){               
        PageReference pref=new PageReference('/apex/ReservationPage');
        pref.setRedirect(true);
        return pref;
    }
    
}