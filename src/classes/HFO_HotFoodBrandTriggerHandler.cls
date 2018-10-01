//
// Apex Class Name: HFO_HotFoodBrandTriggerHandler
// For Apex Trigger: HotFoodBrandTrigger
// Description: Apex trigger handler class for sobject "HotFoodBrand".
//
// 31/08/2018   Himanshu Patel    Original
public class HFO_HotFoodBrandTriggerHandler implements HFO_ITriggerHandler {
	// Allows unit tests (or other code) to disable this trigger for the transaction
    public static Boolean TriggerDisabled = false;

	public void BeforeInsert(List<SObject> newItems) {}
    
    public void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
		
		//When a user updates the brand name, all children Account Names should update to {BrandName__c} - {Account.BillingStreet}, e.g. Nando’s - Goodge Street. 
		//create a collection of accounts linked to updated Brands
		List<Account> updateAccountName = new List<Account>();

		//Step 1: Collect list of Brand names which are being updated
		for(HotFoodBrand__c hotfood : (List<HotFoodBrand__c>)newItems.values()) {
			
			//check if only Brand name is changed
			if(hotfood.Name != ((HotFoodBrand__c)oldItems.get(hotfood.Id)).Name){
				System.Debug('HotFoodBrand Name only changed :');
				String hotFoodBrandName =  hotfood.Name;
				System.Debug('HotFoodBrandName :'+hotFoodBrandName);
				
				//Step 2: Get the accounts linked with Brand names
				//In loop query to avoid exceeding heap size
				for(List<Account> accountsWithBrands : [Select Id, BillingStreet from Account where Brand_Name__c =: hotfood.Id]) {
					System.Debug('Accounts Related to the Brands :'+accountsWithBrands);
					//Step 3:update the Account Name field
					for(Account acc : accountsWithBrands)   {
						if(acc.BillingStreet != null) {
							acc.Name =  hotFoodBrandName + ' - '+ acc.BillingStreet;
						}else{
							acc.Name =  hotFoodBrandName + ' - ' + 'Dummy street name';
						}
						updateAccountName.add(acc);
					}
				}

				//Step 4:Bulkify update the accounts
				update updateAccountName;
				System.Debug('Account name is updated for accounts' +updateAccountName);
			}else{
				System.Debug('Something else is changed');
			}
		}
		
	}

	public void BeforeDelete(Map<Id, SObject> oldItems) {}
 
    public void AfterInsert(Map<Id, SObject> newItems) {}
 
    public void AfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {}
 
    public void AfterDelete(Map<Id, SObject> oldItems) {}
 
    public void AfterUndelete(Map<Id, SObject> oldItems) {}
	
	/*
    Checks to see if the trigger has been disabled either by custom setting or by running code
    */
    public Boolean IsDisabled() {
		/*if (TriggerSettings__c.getinstance().HotFoodBrand_Trigger_Disabled__c)
            return true;
        else
          	return TriggerDisabled;
		*/
		return false;		  
	}
}