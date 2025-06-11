public class EventTaskHealthCheckTriggerHandler {
    
    public void handlerAfterInsert(List<Event_Task__c> newEventTasks) {
        updateEventFlags(newEventTasks);
    }
    
    public void handlerAfterUpdate(List<Event_Task__c> newEventTasks, Map<Id, Event_Task__c> oldEventTasks) {
        updateEventFlags(newEventTasks);
    }
    
    public void handlerAfterDelete(List<Event_Task__c> deletedEventTasks) {
        updateEventFlags(deletedEventTasks);
    }
    
    private void updateEventFlags(List<Event_Task__c> eventTasks) {
        Set<Id> eventPlanId = new Set<Id>();
        List<Event_Plan__c> eventPlansToUpdate = new List<Event_Plan__c>();
        
        Map<Id, Decimal> taskCompletionPercentMap = new Map<Id, Decimal>();
        Map<Id, Integer> taskPlanCompletedCountMap = new Map<Id, Integer>();
        Map<Id, Integer> taskPlanTotalCountMap = new Map<Id, Integer>();
        
        Integer taskPlanCompletedCount = 0;
        Integer taskPlanTotalCount = 0;
        Decimal taskCompletionPercent;
        
        for(Event_Task__c task: eventTasks){
            eventPlanId.add(task.Event_Plan__c);          
        }
        for(AggregateResult arCompleted : [SELECT Event_Plan__c,count(id) FROM Event_Task__c
											WHERE Task_Status__c = 'Completed' AND Event_Plan__c In : eventPlanId
											GROUP BY Event_Plan__c]){
			taskPlanCompletedCountMap.put((Id)arCompleted.get('Event_Plan__c'),(Integer)arCompleted.get('expr0'));
                                           }
        for(AggregateResult arTotal : [SELECT Event_Plan__c,count(id) FROM Event_Task__c
											WHERE Event_Plan__c In : eventPlanId
											GROUP BY Event_Plan__c]){
			taskPlanTotalCountMap.put((Id)arTotal.get('Event_Plan__c'),(Integer)arTotal.get('expr0'));
                                           }
        Date eventDate;
        for(Event_Plan__c eventPlan : [SELECT Id, Event_Date__c FROM Event_Plan__c WHERE Id In : eventPlanId]){
            taskPlanCompletedCount = 0;
            if(eventPlan.Event_Date__c != NULL){
                eventDate =Date.newinstance(eventPlan.Event_Date__c.year(), eventPlan.Event_Date__c.month(), eventPlan.Event_Date__c.day());
            }
            if(taskPlanCompletedCountMap.containskey(eventPlan.Id)){
                taskPlanCompletedCount = taskPlanCompletedCountMap.get(eventPlan.Id);
            }
            taskCompletionPercent = (taskPlanCompletedCount/taskPlanTotalCountMap.get(eventPlan.Id))*100;
            System.debug('taskCompletionPercent' + taskCompletionPercent);
            
            if(eventDate <= System.today().addDays (7) && taskCompletionPercent <= 50.0){
                eventPlan.Event_Flag__c = 'Critical';
            }
            else if(taskCompletionPercent == 100.0){ 
                eventPlan.Event_Flag__c = 'Completed';
            }
            else{
                eventPlan.Event_Flag__c = 'On Track';
            }
            eventPlansToUpdate.add(eventPlan);
            if(eventPlansToUpdate.size()>0){
                update eventPlansToUpdate;
            }
        }
    }  
}