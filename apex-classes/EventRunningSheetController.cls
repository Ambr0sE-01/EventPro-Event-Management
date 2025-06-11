public with sharing class EventRunningSheetController {

    @AuraEnabled(cacheable=true)
    public static Event_Plan__c getEventDetails(Id recordId) {
        return [
            SELECT Event_Name__c, Event_Date__c
            FROM Event_Plan__c
            WHERE Id = :recordId
            LIMIT 1
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Event_Task__c> getTasks(Id recordId) {
        return [
            SELECT Id, Name, Task_Name__c, Due_Date__c, Assigned_To__c
            FROM Event_Task__c
            WHERE Event_Plan__c = :recordId
            ORDER BY Due_Date__c ASC
        ];
    }
}