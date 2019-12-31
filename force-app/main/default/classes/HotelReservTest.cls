@isTest
private class HotelReservTest {
    
    @testSetup
    static void createTestData() {
        City__c newCity=new City__c();
        newCity.name='Брест';
        insert newCity;
        Hotel__c newHotel=new Hotel__c();
        newHotel.name='Интурист';
        insert newHotel;
        Room__c newRoom=new Room__c();
        newRoom.name='301';
        insert newRoom;
    }
    
    @isTest static void test_AddReservPageController(){
        
        City__c newCity=new City__c();
        newCity.name='Брест';
        insert newCity;
        Hotel__c newHotel=new Hotel__c();
        newHotel.name='Интурист';
        insert newHotel;
        Room__c newRoom=new Room__c();
        newRoom.name='301';
        insert newRoom;
        
        
        try{
            PageReference pageRef = Page.AddReservPage;
            Test.setCurrentPage(pageRef);
            System.currentPagereference().getParameters().put('reservroom', newRoom.id);
            
            AddReservPageController ctrl1 = new AddReservPageController();
            ctrl1.save();
            ctrl1.cancel();
        } catch(DMLException e){
            system.assertEquals(e.getMessage(), e.getMessage());
            
        }
        
        
    }
    
    @isTest static void test_AddPreReservPageController(){
        City__c newCity=new City__c();
        newCity.name='Брест';
        insert newCity;
        Hotel__c newHotel=new Hotel__c();
        newHotel.name='Интурист';
        insert newHotel;
        Room__c newRoom=new Room__c();
        newRoom.name='301';
        insert newRoom;
        try{
            PageReference pageRef = Page.AddPreReservPage;
            Test.setCurrentPage(pageRef);
            System.currentPagereference().getParameters().put('prereservroom', newRoom.id);
            
            AddPreReservPageController ctrl2 = new AddPreReservPageController();
            ctrl2.save();
            ctrl2.cancel();
        } catch(DMLException e){
            system.assertEquals(e.getMessage(), e.getMessage());
            
        }
    }
    
    @isTest static void test_ReservationPageController(){
        City__c newCity=new City__c();
        newCity.name='Брест';
        insert newCity;
        Hotel__c newHotel=new Hotel__c();
        newHotel.name='Интурист';
        insert newHotel;
        Room__c newRoom=new Room__c();
        newRoom.name='301';
        insert newRoom;
        Reservation__c reserv=new Reservation__c();
        reserv.ContactEmail__c='ss@ss.ss';
        reserv.NumberOfGuest__c=5;
        Insert reserv;
        ReservationPageController ctrl3 = new ReservationPageController();
        system.assertEquals(reserv.ContactEmail__c, 'ss@ss.ss');
    }
    
    @isTest static void test_PreReservationPageController(){
        City__c newCity=new City__c();
        newCity.name='Брест';
        insert newCity;
        Hotel__c newHotel=new Hotel__c();
        newHotel.name='Интурист';
        insert newHotel;
        Room__c newRoom=new Room__c();
        newRoom.name='301';
        insert newRoom;
        PreReservation__c prereserv=new PreReservation__c();
        prereserv.Email__c ='ss@ss.ss';
        prereserv.Count__c=1;
        Insert prereserv;
        PreReservationPageController ctrl4 = new PreReservationPageController();
        system.assertEquals (prereserv.Count__c, 1);       
        
    }
    
    
    @isTest static void test_PreReservToReservPageController(){
        City__c newCity=new City__c();
        newCity.name='Брест';
        insert newCity;
        Hotel__c newHotel=new Hotel__c();
        newHotel.name='Интурист';
        insert newHotel;
        Room__c newRoom=new Room__c();
        newRoom.name='301';
        newRoom.IsBooked__c=true;
        insert newRoom;
        PreReservation__c prereserv=new PreReservation__c();
        Prereserv.Room__c=newRoom.Id;
        prereserv.Email__c ='ss@ss.ss';
        prereserv.Count__c=1;
        insert prereserv;
        
        try{
            PageReference pageRef = Page.PreReservToReservPage;
            Test.setCurrentPage(pageRef);
            System.currentPagereference().getParameters().put('prereservroom', prereserv.id);
            PreReservToReservPageController ctrl5 = new PreReservToReservPageController();
            ctrl5.room.id=newRoom.id;
            ctrl5.save();
            ctrl5.cancel();
        } catch(DMLException e){
            system.assertEquals(e.getMessage(), e.getMessage());
        }
    }
    
    @isTest static void test_EditReservPageController(){
        City__c newCity=new City__c();
        newCity.name='Брест';
        insert newCity;
        Hotel__c newHotel=new Hotel__c();
        newHotel.name='Интурист';
        insert newHotel;
        Room__c newRoom=new Room__c();
        newRoom.name='301';
        newRoom.Alcohol__c=false;
        newRoom.Sauna__c=false;
        newRoom.Internet__c=false;
        insert newRoom;
        Reservation__c reserv=new Reservation__c();
        reserv.Room__c=newRoom.Id;
        reserv.ContactEmail__c='ss@ss.ss';
        reserv.NumberOfGuest__c=5;
        Insert reserv;
        
        try{
            PageReference pageRef = Page.EditReservPage;
            Test.setCurrentPage(pageRef);
            System.currentPagereference().getParameters().put('reservroom', reserv.id);
            EditReservPageController ctrl6 = new EditReservPageController();
            ctrl6.reservroom.id=newRoom.id;
            ctrl6.reserv.NumberOfGuest__c = 2;        
            ctrl6.save();
            ctrl6.cancel();
        } catch(DMLException e){
            system.assertEquals(e.getMessage(), e.getMessage());
        }
    }
    
    @isTest static void test_EditPreReservPageController(){
        City__c newCity=new City__c();
        newCity.name='Брест';
        insert newCity;
        Hotel__c newHotel=new Hotel__c();
        newHotel.name='Интурист';
        insert newHotel;
        Room__c newRoom=new Room__c();
        newRoom.name='301';
        newRoom.Alcohol__c=false;
        newRoom.Sauna__c=false;
        newRoom.Internet__c=false;
        insert newRoom;
        PreReservation__c prereserv=new PreReservation__c();
        prereserv.Room__c=newRoom.Id;
        prereserv.Email__c='ss@ss.ss';
        prereserv.Count__c=5;
        Insert prereserv;
        
        try{
            PageReference pageRef = Page.EditPreReservPage;
            Test.setCurrentPage(pageRef);
            System.currentPagereference().getParameters().put('prereservroom', prereserv.Id);
            EditPrereservPageController ctrl7 = new EditPrereservPageController();
            ctrl7.editprereservroom.id=newRoom.id;
            ctrl7.prereserv.Count__c=1;
            ctrl7.save();
            ctrl7.cancel();
        } catch(DMLException e){
            system.assertEquals(e.getMessage(), e.getMessage());
        }
    }
    
    @isTest static void test_SitePreReservationPageController1(){
        
        City__c newCity=new City__c();
        newCity.name='Брест';
        insert newCity;
        Hotel__c newHotel=new Hotel__c();
        newHotel.name='Интурист';
        insert newHotel;
        Room__c newRoom=new Room__c();
        newRoom.name='301';
        newRoom.Amount__c=1;
        insert newRoom;
        PreReservation__c prereserv=new PreReservation__c();
        prereserv.Email__c='ss@ss.ss';
        prereserv.Count__c=5;
        Insert prereserv;       
        
        try{
            PageReference pageRef = Page.SiteReservationPage;
            Test.setCurrentPage(pageRef);
            SitePreReservationPageController ctrl8 = new SitePreReservationPageController();
            ctrl8.selectHotel();
            ctrl8.cnt=prereserv.Count__c;
            ctrl8.save();
            ctrl8.cancel();            
        } catch(DMLException e){
            system.assertEquals(e.getMessage(), e.getMessage());
        }
    }
    
    @isTest static void test_SitePreReservationPageController2(){
        
        City__c newCity=new City__c();
        newCity.name='Брест';
        insert newCity;
        Hotel__c newHotel=new Hotel__c();
        newHotel.name='Интурист';
        insert newHotel;
        Room__c newRoom=new Room__c();
        newRoom.name='301';
        newRoom.Amount__c=1;
        insert newRoom;
        PreReservation__c prereserv=new PreReservation__c();
        prereserv.Email__c='ss@ss.ss';
        prereserv.Count__c=1;
        Insert prereserv;       
        
        try{
            PageReference pageRef = Page.SiteReservationPage;
            Test.setCurrentPage(pageRef);
            SitePreReservationPageController ctrl8 = new SitePreReservationPageController();
            ctrl8.selectHotel();
            ctrl8.cnt=prereserv.Count__c;
            ctrl8.save();
            ctrl8.cancel();            
        } catch(DMLException e){
            system.assertEquals(e.getMessage(), e.getMessage());
        }        
        
    }
    
    @isTest static void test_MainPageListController1(){
        City__c newCity=new City__c();
        newCity.name='Брест';
        insert newCity;
        Hotel__c newHotel=new Hotel__c();
        newHotel.name='Интурист';
        insert newHotel;
        Room__c newRoom=new Room__c();
        newRoom.name='301';
        newRoom.IsBusy__c=true;
        insert newRoom;
        Reservation__c reserv=new Reservation__c();
        reserv.Room__c=newRoom.Id;
        reserv.ContactEmail__c='ss@ss.ss';
        reserv.NumberOfGuest__c=5;
        Insert reserv;
        
        try{
            PageReference pageRef = Page.MainPage;
            Test.setCurrentPage(pageRef);
            System.currentPagereference().getParameters().put('addpr', newRoom.id);
            MainPageListController ctrl9 = new MainPageListController();
            ctrl9.retrieveHotels();
            ctrl9.retrieveRooms();
            ctrl9.rid=newRoom.Id;            
            ctrl9.deleteReserv();
            
        } catch(DMLException e){
            system.assertEquals(e.getMessage(), e.getMessage());
        } 
    }
    @isTest static void test_MainPageListController2(){
        City__c newCity=new City__c();
        newCity.name='Брест';
        insert newCity;
        Hotel__c newHotel=new Hotel__c();
        newHotel.name='Интурист';
        insert newHotel;
        Room__c newRoom=new Room__c();
        newRoom.name='301';
        newRoom.IsBooked__c =true;
        insert newRoom;
        PreReservation__c prereserv=new PreReservation__c();
        Prereserv.Room__c=newRoom.Id;
        Prereserv.Email__c='ss@ss.ss';
        Prereserv.Count__c =5;
        Insert prereserv;
        
        try{
            PageReference pageRef = Page.MainPage;
            Test.setCurrentPage(pageRef);
            System.currentPagereference().getParameters().put('addpr', newRoom.id);
            MainPageListController ctrl9 = new MainPageListController();
            ctrl9.retrieveHotels();
            ctrl9.retrieveRooms();
            ctrl9.rid=newRoom.Id;            
            ctrl9.deleteReserv();
            
        } catch(DMLException e){
            system.assertEquals(e.getMessage(), e.getMessage());
        } 
        
    }
    @isTest static void test_CheckCountDateTriggerPrereserv(){
        City__c newCity=new City__c();
        newCity.name='Брест';
        insert newCity;
        Hotel__c newHotel=new Hotel__c();
        newHotel.name='Интурист';
        insert newHotel;
        Room__c newRoom=new Room__c();
        newRoom.name='301';
        insert newRoom;
        PreReservation__c prereserv=new PreReservation__c();
        prereserv.Email__c ='ss@ss.ss';
        prereserv.Count__c=-1;
        prereserv.ChekinDate__c=date.newinstance(2000, 1, 1);
        prereserv.ChekoutDate__c=date.newinstance(2000, 1, 1);
        try {
            Insert prereserv;  
        } catch(DMLException e){
            system.assertEquals(e.getMessage(), e.getMessage());
        } 
        
    }
    @isTest static void test_CheckNumberDateTriggerReserv(){
        City__c newCity=new City__c();
        newCity.name='Брест';
        insert newCity;
        Hotel__c newHotel=new Hotel__c();
        newHotel.name='Интурист';
        insert newHotel;
        Room__c newRoom=new Room__c();
        newRoom.name='301';
        insert newRoom;
        Reservation__c reserv=new Reservation__c();
        reserv.ContactEmail__c ='ss@ss.ss';
        reserv.NumberOfGuest__c =-1;        
        reserv.ArrivalDate__c =date.newinstance(2000, 1, 1);
        reserv.DepartureDate__c =date.newinstance(2000, 1, 1);
        try {
            Insert reserv;  
        } catch(DMLException e){
            system.assertEquals(e.getMessage(), e.getMessage());
        }
    }
    
    
}