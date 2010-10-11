Feature: Add new task
	 As a user
	 I want to be able to add a new task
	 So that I can deal with it later

	 Background:
		Given I am logged in as "sample@email.com"

	 Scenario: Add a task to a blank dashboard and visualize it
	 	Given I am on the dashboard
		And the to-do list for today is blank
		When I add a new task with description "Do laundry"
		Then I should see a task entry with description “Do laundry”
		And there should only be one task on the to-do list for today

	 Scenario: Add a task while in the middle of another task
	 	Given I am on a task timer page
		And I go back to the dashboard
      		When I add a new task with description “Do laundry”
      		Then I should see a task entry with description “Do laundry”

	 Scenario: Add more tasks than alotted for one day
	 	Given I am on the dashboard
		And my to-do list for today is full
		When I add a new task with description "Do laundry"
		Then I should see "Error: Too many tasks!"
		And my task should not be on the to-do list

Given there is a calendar with current date October 7, 2010
And I am currently on this date
When the clock hits October 8, 2010
Then I should have a fresh todo list for the new day

Given there is a calendar
When I click on the day after the current
Then I should be on the todo list for that day
