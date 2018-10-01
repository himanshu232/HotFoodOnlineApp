public with sharing  class ListAccountApexController {
//Apex server controller
    @AuraEnabled
    public static List<Account> getAccountsItems(String masterItemId) {
        return [SELECT Id, Name, BillingStreet FROM Account
				WHERE Brand_Name__c =: masterItemId];
    }
}