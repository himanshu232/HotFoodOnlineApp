// Apex Class Name: HFO_TriggerDispatcher
// Description: The dispatcher is responsible for making sure all of the applicable methods on your trigger handler 
//              are called, depending on the current trigger context.
//              It also contains a check to make sure that the trigger has not been disabled. 
//
// 31/08/2018   Himanshu Patel    Original
public class HFO_TriggerDispatcher 
{
	/* 
	Call this method from your trigger, passing in an instance of a trigger handler which implements ITriggerHandler
	This method will fire the appropriate methods on the handler depending on the trigger context
	*/
	public static void Run(HFO_ITriggerHandler handler) { 
		 // Check to see if the trigger has been disabled. If it has, return
        if (handler.IsDisabled())
            return;
		//Detect the current trigger context and fire the relevant methods on the trigger handler:

		//Before Trigger
		if(Trigger.IsBefore) {
 					if (Trigger.IsInsert)
                        handler.BeforeInsert(trigger.new);
         
                    if (Trigger.IsUpdate)
						handler.BeforeUpdate(trigger.newMap, trigger.oldMap);
         
                    if (Trigger.IsDelete)
                        handler.BeforeDelete(trigger.oldMap);
		}
		//After Trigger logic
		if(Trigger.IsAfter)	{
					if (Trigger.IsInsert)
                        handler.AfterInsert(Trigger.newMap);
         
                    if (Trigger.IsUpdate)
                        handler.AfterUpdate(trigger.newMap, trigger.oldMap);
         
                    if (trigger.IsDelete)
                        handler.AfterDelete(trigger.oldMap);
         
                    if (trigger.isUndelete)
                        handler.AfterUndelete(trigger.oldMap);
		}
       
	}
}