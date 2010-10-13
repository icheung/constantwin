Feature: Start task
	 As a user
	 I want to be able to start one of the tasks from my list of tasks
	 So that I can begin working on that task

	 Background:
		Given I am logged in as "sample@email.com"
		And I have a task with description "Do laundry"
		And I have a task with description "Do homework"

	 Scenario: I start the task
	 	Given I am on the dashboard
		When I click “Start” for "Do laundry"
		Then I should be on the task timer page for "Do laundry"
		And I should see a timer entry field

	 Scenario: I start a task while in the middle of another task
		Given I am on the task timer page for "Do laundry"
		And I go back to the dashboard
		When I click “Start” for "Do homework"
		Then I should see "Error: Finish your present task first"
		And the second task should not be started
