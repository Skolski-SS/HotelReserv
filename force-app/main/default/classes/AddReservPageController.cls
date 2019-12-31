public class AddReservPageController {
    public Reservation__c reserv{get; set;}
    public Room__c reservroom{get; set;}
    Public String roomid = System.currentPagereference().getParameters().get('reservroom');
   
   
    public AddReservPageController(){
        reserv = new Reservation__c();
        reservroom= [SELECT id,Name,City__c, Hotel__c, IsBusy__c, IsBooked__c,
                     Alcohol__c, Internet__c, Sauna__c FROM Room__c WHERE id=:roomid];
        reserv.City__c=reservroom.City__c;
        reserv.Hotel__c=reservroom.Hotel__c;
        reserv.Room__c= reservroom.id;

    }
    
    public Pagereference save(){        
        try {
            reservroom.IsBusy__c = true;
            insert reserv;
            update reservroom;
            PageReference pref=new PageReference('/apex/MainPage');
            pref.setRedirect(true);
            return pref;
            }catch (DMLException e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, '"Something went wrong !"'));
            return null;
        }       
       
    }    
    public Pagereference cancel(){               
            PageReference pref=new PageReference('/apex/MainPage');
            pref.setRedirect(true);
            return pref;

    }
    

}