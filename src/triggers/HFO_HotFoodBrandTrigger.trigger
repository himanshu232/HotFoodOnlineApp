//
// Apex Trigger Name: HFO_HotFoodBrandTrigger
// For Object: HotFoodBrand__c
// Description: Apex trigger for sobject "HotFoodBrand__c".
//
// 31/08/2018   Himanshu Patel    Original
trigger HFO_HotFoodBrandTrigger on HotFoodBrand__c (before update) { 
        HFO_TriggerDispatcher.Run(new HFO_HotFoodBrandTriggerHandler());
}