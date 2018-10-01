//
// Apex Test Class Name: HFO_HotFoodBrandTriggerTest
// For Trigger: HFO_HotFoodBrandTriggerTest
// Description: Test class for HFO_HotFoodBrandTriggerTest
//
// 31/08/2018    Himanshu Patel    Original
//
@isTest
private class HFO_HotFoodBrandTriggerTest
{
	@isTest
	static void updateHotFoodBrandName() {
		
	   User u = setupUser();
	   
	   test.StartTest(); 
				insert u;
				User u1 = [SELECT Id FROM User WHERE Alias = 'hpatel' AND Email='standarduser@testorg.com'];
					System.RunAs(u1){

						//Create a HotFoodBrand record
						HotFoodBrand__c hfb 		=  new HotFoodBrand__c();
						hfb.Name 					= 'Test Brand';
						insert hfb;
						

						//Create a linked account with Brand name
						Account newAcc1 			= new Account();
						newAcc1.Name				= 'Test account street1';
						newAcc1.Brand_Name__c 		= hfb.id;
						newAcc1.BillingStreet 		= '181, London Road';
						insert newAcc1;

						Account newAcc2 			= new Account();
						newAcc2.Name				= 'Test account street12';
						newAcc2.Brand_Name__c 		= hfb.id;
						insert newAcc2;

						//Update the hotfood name to trigger
						hfb.Name 					= 'My Test Brand';
						update hfb;
						
						Account acc1 = [select Name from Account where Id=:newAcc1.id];
						Account acc2 = [select Name from Account where Id=:newAcc2.id];
						System.assertEquals('My Test Brand - 181, London Road', acc1.Name, 'Check the assertion on first account name');
						System.assertEquals('My Test Brand - Dummy street name', acc2.Name,'Check the assertion on second account name without street name');
						System.Debug('Test HotFoodBrand record has been created ' +hfb.Id);
					} //end runas(u1)
		test.StopTest();
	}
	@isTest
	static void updateHotFoodBrandExceptName() {
		//setup an user
	   User u = setupUser();
	   test.StartTest(); 
				insert u;
				User u2 = [SELECT Id FROM User WHERE Alias = 'hpatel' AND Email='standarduser@testorg.com'];
				System.RunAs(u2){

				//Create a HotFoodBrand record
				HotFoodBrand__c hfb 		=  new HotFoodBrand__c();
				hfb.Name 					= 'Test Brand 2';
				hfb.Description__c 			= 'Test Brand Description 2';
				insert hfb;
				

				//Create a linked account with Brand name
				Account newAcc1 			= new Account();
				newAcc1.Name				= 'Test account street 2';
				newAcc1.Brand_Name__c 		= hfb.id;
				newAcc1.BillingStreet 		= '181, Church Road';
				insert newAcc1;

				Account newAcc2 			= new Account();
				newAcc2.Name				= 'Test account name - No change';
				newAcc2.Brand_Name__c 		= hfb.id;
				insert newAcc2;

				//Update the hotfood name to trigger
				hfb.Description__c			= 'My Test Brand Description only changed';
				update hfb;

				
				Account acc1 = [select Name from Account where Id=:newAcc1.id];
				Account acc2 = [select Name from Account where Id=:newAcc2.id];
				//No change the the Account name because in Brand object other fields are changed except Name
				System.assertEquals('Test account street 2', acc1.Name, 'Check the assertion on first account name');
				System.assertEquals('Test account name - No change', acc2.Name,'Check the assertion on second account name without street name');
			}// System.RunAs(u2)
		test.StopTest();	
	}
	@isTest
	static void updateHotFoodBrandBulk() {
		//setup an user
	   User u = setupUser();
	   test.StartTest(); 
				insert u;
				User u2 = [SELECT Id FROM User WHERE Alias = 'hpatel' AND Email='standarduser@testorg.com'];
				System.RunAs(u2){
						System.debug('Inserting Brand records... (bulk validation)');
						List<HotFoodBrand__c> brands = new List<HotFoodBrand__c>();
						for(integer i=0; i<97; i++){
							brands.add(new HotFoodBrand__c(Name = 'Brand' + i, Description__c = 'Brand' + i + 'Description'));
							
						}
						insert brands;
						System.Debug('brand added ' +brands);

						//for each brand create couple of accounts
						//List<HotFoodBrand__c>  newBrands = [Select Id, Name from HotFoodBrand__c];
						List<Account> accwithstreet = new List<account>();
						List<Account> accwithoutstreet = new List<account>();
						for(integer i=0; i<brands.size(); i++){
								//Create a linked account with Brand name
								Account newTestAcc	= new Account(Name = 'Test account with Street' +i , Brand_Name__c = brands[i].id, BillingStreet = i + ', Church street');
								accwithstreet.add(newTestAcc);
								Account newTestAcc1	= new Account(Name = 'Test account without Street' +i , Brand_Name__c = brands[i].id);
								accwithoutstreet.add(newTestAcc1);
						}
						insert accwithstreet;
						insert accwithoutstreet;

						//Update All brand names
						List<HotFoodBrand__c>  updateBrands = new List<HotFoodBrand__c>();
						for(HotFoodBrand__c brand : brands){
							brand.Name 	= 'My udpated Brand';
							updateBrands.add(brand);
						}
						
						update updateBrands;

						System.Debug('Bulk brands inserted ' +brands);
					}
		test.StopTest();	
	}

	private static User setupUser(){
		//setup an user
	   Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
       User u = new User(Alias = 'hpatel', Email='standarduser@testorg.com', 
       EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
       LocaleSidKey='en_GB', ProfileId = p.Id, TimeZoneSidKey='Europe/London', UserName='4323f1a8-2698-44c4-a234-dfcf80fa6a6c@testorg.com');
	   return u;
	}
}