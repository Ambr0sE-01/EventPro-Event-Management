# EventPro-Event-Management

🔧 Salesforce Event Management App – EventPro (Hands-On Project)
💼 Project Overview:
Developed a custom Salesforce application for EventPro, an event planning company, to streamline event operations, automate processes, and improve data visibility.

✅ Key Features & Implementations:
Custom Object Modeling

Created three custom objects: Event Plan, Event Task, and Event Expense.

Configured appropriate fields including relationships (Master-Detail), custom formulas, and picklists.

Added 3 roll-up summary fields on Event Plan to track task completion and financial stats.

UI Customization

Created custom tabs for each object to ensure accessibility in the Salesforce UI.

Configured Lightning App named "Event Management App" to unify the workspace.

Approval Process Automation

Built a custom approval process on the Event Plan object.

Created a custom approval status field and an email alert template for approved events.

Configured a CEO user as the approver with final approval/rejection actions.

Budget Planning Feature

Developed a Screen Flow named "Event Budget Calculator" to estimate event expenses.

Enabled guided user input for various expense categories.

Added the flow as a Quick Action to the Event Plan record page for easy access.

Data Aggregation with Apex

Created an EventSummaryController Apex class with methods to:

Count total and open tasks for an event.

Summarize expenses by category.

Fetch the most expensive event expense.

Invoked these Apex methods in a Screen Flow for live reporting.

Event Health Status Indicator

Built a dynamic event health logic using Apex Trigger and Handler Class.

Automatically updates a flag on Event Plan based on:

% of open tasks.

Proximity to the event date (within 7 days).

Event status marked as Critical if >50% tasks are open and the event is near.

🧠 Skills & Tools Applied:
Salesforce Custom Objects & Relationships

Approval Processes & Email Alerts

Flow Builder (Screen Flows & Quick Actions)

Apex Triggers, Classes & SOQL

Declarative + Programmatic Automation

Lightning App Builder & UI Configuration
