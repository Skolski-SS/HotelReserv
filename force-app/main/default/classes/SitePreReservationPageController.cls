public class SitePreReservationPageController {
    public List<SelectOption>City_List{get;set;}
    public List<SelectOption>Hotel_List{get;set;}
    public PreReservation__c reserv{get;set;}
    public String selectCity{get;set;}
    public boolean flag{get;set;}
    public Double cnt{get;set;}
    public Room__c roomserv{get;set;}
    public Room__c resRoom {get;set;}
    
    
    //Constructor
    public SitePreReservationPageController(){
        
        City_List=new List<SelectOption>();
        Hotel_List=new List<SelectOption>();
        
        List<City__c> listCitys =[SELECT Id, Name FROM City__c];
        
        City_List.add(new SelectOption('','--Select City--'));
        for(City__c citys:listCitys)
            
            City_List.add(new SelectOption(citys.Id,citys.Name));
        
        Hotel_List.add(new SelectOption('','--Select Hotel--'));
        flag=False;
        reserv = new PreReservation__c();
        roomserv = new Room__c();
    }
    
    public void selectHotel(){
        List<Hotel__c> HotelName=[SELECT id, Name FROM Hotel__c WHERE City__c=:selectCity];
        Hotel_List.clear();
        if(HotelName.size()>0){
            Hotel_List.add(new SelectOption('','--Select Hotel--'));    
            for(Hotel__c hotel: HotelName) 
                Hotel_List.add(new SelectOption(Hotel.Id, Hotel.Name));
            flag=false;
        } else 
            flag=true;
        
    }
    
    public pagereference save(){        
        try {
            reserv.Count__c = cnt;
            List<Room__c> room = [SELECT id, Amount__c, Alcohol__c, Internet__c, Sauna__c
                                  FROM Room__c WHERE IsBusy__c = false AND IsBooked__c = false AND Amount__c >= :cnt AND Hotel__c = :reserv.Hotel__c];             
            
            if (room != null && room.size() > 0 )  
            {
                reserv.Room__c =  room[0].id; 
                resRoom = room[0];
                resRoom.Internet__c=roomserv.Internet__c;
                resRoom.Sauna__c=roomserv.Sauna__c;
                resroom.Alcohol__c=roomserv.Alcohol__c; 
                resRoom.isBooked__c = true;
                insert reserv;      
                update resRoom;           
                SendMail (reserv.Email__c, 'Hotel manager', 'You have been successfully booked a room.');
                
            }
            if (room == null && room.size() == 0 ) 
            {
                
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Something went wrong !'));
                
            }
            
            PageReference pref=new PageReference('/apex/SiteReservationPage');
            pref.setRedirect(true);
            return pref;
            
        }catch (DMLException e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, '"Something went wrong !"'));
            return null;
        }
        
    }
    
    public Pagereference cancel(){               
        PageReference pref=new PageReference('/apex/SiteReservationPage');
        pref.setRedirect(true);
        return pref;
    }
    
    public Pagereference SendMail(String Email, String Subject, String Message)
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {Email};
            mail.setToAddresses(toAddresses);
        
        mail.setSubject(Subject);
        mail.setPlainTextBody(Message);
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        for ( Messaging.SendEmailResult result : r )
        {
            if ( !r[0].isSuccess () )
            {
                System.debug ( result  );
            }
            else
            {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.INFO, 'Email Sent Successfully' );
                ApexPages.addMessage(msg);
            }
        }
        return null;
    }
    
}