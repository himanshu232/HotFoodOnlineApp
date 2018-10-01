// Apex Class Name: HFO_ITriggerHandler
// Description: The interface dictates which methods every trigger handler must implement. By implementing the methods in this class,
//              the HFO_ITriggerHandler can be confident that the trigger handler has a method for each of these events:
//   Before/After Insert
//   Before/After Update
//   Before/After Delete
//   After Undelete
//   IsDisabled
//
// 31/08/2018   Himanshu Patel    Original
public interface HFO_ITriggerHandler {
    void BeforeInsert(List<SObject> newItems);
 
    void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems);
 
    void BeforeDelete(Map<Id, SObject> oldItems);
 
    void AfterInsert(Map<Id, SObject> newItems);
 
    void AfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems);
 
    void AfterDelete(Map<Id, SObject> oldItems);
 
    void AfterUndelete(Map<Id, SObject> oldItems);
 
    Boolean IsDisabled();

}