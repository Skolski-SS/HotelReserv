public with sharing class MainPageListController {
    
    public List<City__c> Cities{get; set;}
    public List<Hotel__c> Hotels{get; set;}
    public List<Room__c> Rooms{get;set;}
    public String CityId{get; set;}
    public String hotelId{get;set;}
    public String rid{get; set ;}
    Public String addpr = System.currentPagereference().getParameters().get('addpr');
    
    public MainPageListController(){
        Cities = getCities();
    }

    private List<City__c> getCities(){
        List<City__c> listCities = [SELECT Id, Name FROM City__c];
        return listCities;
        
    }
    public void retrieveHotels(){
        Hotels = [SELECT Id, Name FROM Hotel__c WHERE City__c = :CityId];
    }
    
    public void retrieveRooms(){
        Rooms = [SELECT Id, Hotel__c,Name, KindOfRoom__c, Amount__c,IsBooked__c,IsBusy__c,
                 Alcohol__c, Internet__c, Sauna__c FROM Room__c WHERE hotel__c = :hotelId];
    }
    
    public void deleteReserv(){
        Room__c delBusy=[select id,IsBusy__c,IsBooked__c,
                         Alcohol__c, Internet__c, Sauna__c from Room__c where id=:rid];
        
        if (delBusy.IsBusy__c==true){
            Reservation__c delres=[select id from Reservation__c where Room__c=:delBusy.Id ];
            delBusy.IsBusy__c=false;
            delBusy.Alcohol__c=false;
            delBusy.Internet__c=false;
            delBusy.Sauna__c=false;
            delete delres;
            update delBusy;
            Rooms = [SELECT Id, Hotel__c,Name, KindOfRoom__c, Amount__c,IsBooked__c,IsBusy__c,
                 Alcohol__c, Internet__c, Sauna__c FROM Room__c WHERE hotel__c = :hotelId];
        }
        if (delbusy.IsBooked__c==true){
            PreReservation__c delpreres=[select id from PreReservation__c where Room__c=:delBusy.Id ];
            delBusy.IsBooked__c=false;
            delBusy.Alcohol__c=false;
            delBusy.Internet__c=false;
            delBusy.Sauna__c=false;
            delete delpreres;
            update delBusy;
            Rooms = [SELECT Id, Hotel__c,Name, KindOfRoom__c, Amount__c,IsBooked__c,IsBusy__c,
                 Alcohol__c, Internet__c, Sauna__c FROM Room__c WHERE hotel__c = :hotelId]; 
            
        }
        
    }
    
    
}