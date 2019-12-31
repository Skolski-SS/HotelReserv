public class PrereservToReservPageController {
    public PreReservation__c prereserv{get; set;}
    public Reservation__c reserv{get; set;}
    public Room__c room{get;set;}
    Public String prereservid = System.currentPagereference().getParameters().get('prereservroom');
    
    public PrereservToReservPageController(){
        prereserv = new PreReservation__c();
        reserv = new Reservation__c();
        prereserv= [SELECT id,City__c, Hotel__c, Room__c,ChekinDate__c, ChekoutDate__c, Count__c, Email__c FROM PreReservation__c WHERE id=:prereservid];
        room=[SELECT id,IsBusy__c,IsBooked__c,
               Alcohol__c, Internet__c, Sauna__c FROM Room__c WHERE Room__c.id=:prereserv.Room__c];
        
    }
    
    public Pagereference save(){        
        try {
            reserv.City__c=prereserv.City__c;
            reserv.Hotel__c=prereserv.Hotel__c;
            reserv.Room__c=prereserv.Room__c;
            reserv.ArrivalDate__c=prereserv.ChekinDate__c;
            reserv.DepartureDate__c=prereserv.ChekoutDate__c;
            reserv.NumberOfGuest__c=prereserv.Count__c;
            reserv.ContactEmail__c=prereserv.Email__c;
            room.IsBooked__c = false;
            room.IsBusy__c=true;
            
            insert reserv;
            delete prereserv;
            update room;
            PageReference pref=new PageReference('/apex/ReservationPage');
            pref.setRedirect(true);
            return pref;
        }catch (DMLException e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, '"Something went wrong !"'));
            return null;
        }       
        
    }    
    public Pagereference cancel(){               

            PageReference pref=new PageReference('/apex/PrereservationPage');
            pref.setRedirect(true);
            return pref;
        
    }
}