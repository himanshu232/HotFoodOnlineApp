//
// Apex Class Name: HFO_AccountNameUpdateBatchJob
// Description: Creates the Apex Job that calls the queueable class which queries and updates Account names match the convention listed above {Brand Name} - {Street} and correct them. 
//
global class HFO_AccountNameUpdateBatchJob implements Database.Batchable<sObject> {
	
	String query;
	global HFO_AccountNameUpdateBatchJob() {
		
	}
	//Start method is called automatically at the begining of the apex job. This method colect record or objects on which the operations should be performed. 
	global Database.QueryLocator start(Database.BatchableContext BC) {
		//Only select the records which are has BrandName
		query = 'SELECT Id,Name, Brand_Name__r.Name, BillingStreet FROM Account where Brand_Name__c !=null'; 
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Account> scope) {
		//This batchable will receive a relatively short list of records (default 200) and everything runs in its own transactional context. 
		List<Account> updateNames = new List<Account>();
		for(Account acc : scope) { 
			String requirdAccName = acc.Brand_Name__r.Name +' - ' + acc.BillingStreet;

			System.Debug('Brand Name 				------> ' +acc.Brand_Name__r.Name);
			System.Debug('Actual account name 		------> ' +acc.Name);
			System.Debug('Required account name 	------> ' +requirdAccName);
			
			if(acc.Name != requirdAccName ) {  
					System.Debug('Account name is updated from ----->' +acc.Name + ' <---> ' + requirdAccName);       
           		 	acc.Name = requirdAccName;
				 	updateNames.add(acc);
			}
        }        
        update updateNames;      
	}
	//use this method to send confirmation email notifications etc. 
	global void finish(Database.BatchableContext BC) {}
	
}