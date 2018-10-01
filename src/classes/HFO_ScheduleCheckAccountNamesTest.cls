//
// Apex Class Name: HFO_ScheduleCheckAccountNamesTest
// For Apex Class: HFO_ScheduleCheckAccountNames
// Description: Test class for HFO_ScheduleCheckAccountNames
//
@isTest
private class HFO_ScheduleCheckAccountNamesTest {
	
	@isTest static void testscheduleCheckAccountNames() {
		
		String CRN_EXP = '0 0 12 ? * MON *'; //Once in a week every Monday

		//Create test data
		//Create a HotFoodBrand record
		HotFoodBrand__c hfb 		=  new HotFoodBrand__c();
		hfb.Name 					= 'Test Brand Schedule';
		insert hfb;
		

		//Create a linked account with Brand name
		Account newAcc1 			= new Account();
		newAcc1.Name				= 'Test account Schedule street1';
		newAcc1.Brand_Name__c 		= hfb.id;
		newAcc1.BillingStreet 		= '181, London Road';
		insert newAcc1;

		Test.startTest();

        String jobId = System.schedule('TestHFO_ScheduleCheckAccountNames', CRN_EXP, new HFO_ScheduleCheckAccountNames());
		CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(CRN_EXP, ct.CronExpression);
    	System.assertEquals(0, ct.TimesTriggered);
		
        Test.stopTest();
	}
	
}