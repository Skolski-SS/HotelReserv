trigger CheckNumberDateTrigger on Reservation__c (before insert,before update) {
for(Reservation__c res:Trigger.new){
        if(res.NumberOfGuest__c <= 0){
            res.NumberOfGuest__c.addError('Please enter correct number');
        }
        if(res.ArrivalDate__c< date.today()){
            res.ArrivalDate__c.addError('Incorrect Date');
        }
        if(res.DepartureDate__c< date.today()){
            res.DepartureDate__c.addError('Incorrect Date');
        }   
        
    }
}