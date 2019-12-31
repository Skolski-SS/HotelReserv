public class EditPrereservPageController {

    public PreReservation__c prereserv{get; set;}
    public Room__c editprereservroom{get;set;}
    Public String prereservid = System.currentPagereference().getParameters().get('prereservroom');
    
    public EditPrereservPageController(){
        prereserv = new PreReservation__c();
        prereserv= [SELECT id,City__c, Hotel__c, Room__c,ChekinDate__c, ChekoutDate__c, Count__c, Email__c FROM PreReservation__c WHERE id=:prereservid];
        editprereservroom= [SELECT id,City__c,Name, Hotel__c, IsBooked__c,
                        Alcohol__c, Internet__c, Sauna__c FROM Room__c WHERE id=:prereserv.Room__c];
    }
        
        
        public Pagereference save(){        
        try {                      
            update prereserv;
            update editprereservroom;
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