trigger CheckCountDateTrigger on PreReservation__c (before insert,before update) {
    for(PreReservation__c preres:Trigger.new){
        if(preres.Count__c <= 0){
            preres.Count__c.addError('Please enter correct number');
        }
        if(preres.ChekinDate__c< date.today()){
            preres.ChekinDate__c.addError('Incorrect Date');
        }
        if(preres.ChekOutDate__c< date.today()){
            preres.ChekOutDate__c.addError('Incorrect Date');
        }   
        
    }
}