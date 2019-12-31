public class AddPreReservPageController {
    public PreReservation__c prereserv{get; set;}
    public Room__c prereservroom{get; set;}
    Public String roomid = System.currentPagereference().getParameters().get('prereservroom');
    
    public AddPreReservPageController(){
        prereserv = new PreReservation__c();
        prereservroom= [SELECT id,City__c,Name, Hotel__c, IsBooked__c,
                        Alcohol__c, Internet__c, Sauna__c FROM Room__c WHERE id=:roomid];
        prereserv.City__c=prereservroom.City__c;
        prereserv.Hotel__c=prereservroom.Hotel__c;
        prereserv.Room__c= prereservroom.id;
    }
    
    public Pagereference save(){        
        try {
            prereservroom.IsBooked__c = true;
            insert prereserv;
            update prereservroom;
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