public class EventSummaryController {
    public static Map<String, Integer> getTaskStatusSummary(Id eventPlanId) {
        Map<String, Integer> taskStatusSummary = new Map<String, Integer>();
		for(AggregateResult result: [
            SELECT Task_Status__c, COUNT(Id) taskCount
			FROM Event_Task__c
			WHERE Event_Plan__c =:eventPlanId
            GROUP BY Task_Status__c
        ]){
            taskStatusSummary.put((String)result.get('Task_Status__c'), (Integer)result.get('taskCount'));
        }
        return taskStatusSummary;
    }
    public static List<Event_Task__c> getOpenTasks(Id eventPlanId){
        LIST<Event_Task__c> openTasks = new LIST<Event_Task__c>();
        openTasks = [SELECT Id, Name, Due_Date__c, Task_Status__c
					FROM Event_Task__c
					WHERE Event_Plan__c = :eventPlanId AND Task_Status__c = 'Not Started'
					ORDER BY Due_Date__c DESC  
        ];
        return openTasks;
    }
    public Map<String, Decimal> getExpensesByCategory(Id eventPlanId){
        Map<String, Decimal> expencesByCategory = new Map<String, Decimal>();
        for(AggregateResult result: [
            SELECT Category__c, SUM(Amount__c) sumAmount
 			FROM Event_Expense__c
			WHERE Associated_Event__c = :eventPlanId
            GROUP BY Category__c
        ]){
            expencesByCategory.put((String)result.get('Category__c'), (Decimal)result.get('sumAmount'));
        }
        return expencesByCategory;
    }
    public Event_Expense__c getMostExpensiveExpense(Id eventPlanId){
        Event_Expense__c mostExpensiveExpense;
		mostExpensiveExpense = [
            SELECT Amount__c
			FROM Event_Expense__c
			WHERE Associated_Event__c = :eventPlanId
            ORDER BY Amount__c DESC
            LIMIT 1
        ];
        return mostExpensiveExpense;
    }
        
}