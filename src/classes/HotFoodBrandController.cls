public class HotFoodBrandController {
	@AuraEnabled
    public static List<HotFoodBrand__c> getBrands(){
        return [SELECT Id, name
                FROM HotFoodBrand__c ORDER BY name ASC];
    }
    
    @AuraEnabled
    public static List<HotFoodBrand__c> findByBrandName(String searchKey) {
        String brandname = '%' + searchKey + '%';
        return [SELECT id, name FROM HotFoodBrand__c WHERE name LIKE :brandname];
    }

}