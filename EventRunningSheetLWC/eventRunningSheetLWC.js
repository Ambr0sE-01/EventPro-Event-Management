import { LightningElement, wire, api } from 'lwc';
import getEventDetails from '@salesforce/apex/EventRunningSheetController.getEventDetails';
import getTasks from '@salesforce/apex/EventRunningSheetController.getTasks';

export default class EventRunningSheetLWC extends LightningElement {
    @api recordId;
    eventName;
    eventDate;
    location;
    budget;
    status;
    taskList = [];

    @wire(getEventDetails, { recordId: '$recordId' })
    wiredEventDetails({ error, data }) {
        if (data) {
            this.eventName = data.Event_Name__c;
            this.eventDate = data.Event_Date__c;
            this.location = data.Location__c;
            this.budget = data.Budget__c;
            this.status = data.Status__c;
        } else if (error) {
            console.error('Error fetching event details', error);
        }
    }

    @wire(getTasks, { recordId: '$recordId' })
    wiredTasks({ error, data }) {
        if (data) {
            this.taskList = data;
        } else if (error) {
            console.error('Error fetching tasks', error);
        }
    }
}
