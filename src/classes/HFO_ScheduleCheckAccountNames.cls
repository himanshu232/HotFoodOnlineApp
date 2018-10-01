//
// Apex Class Name: HFO_ScheduleCheckAccountNames
// Description: Creates the Apex Job that calls the queueable class which queries and updates Account names match the convention listed above {Brand Name} - {Street} and correct them. 
//
global class HFO_ScheduleCheckAccountNames implements Schedulable {
	global void execute(SchedulableContext sc) {
		HFO_AccountNameUpdateBatchJob  accountsBatch = new HFO_AccountNameUpdateBatchJob();
		database.executebatch(accountsBatch);
	}
}