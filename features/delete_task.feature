Feature: Delete a task
	 As a user
	 I want to be able to delete a task from my list
	 So that I can remove tasks I don’t want from the list

	 Background:
		Given I am logged in as "sample@email.com"
		And I have a task with description "Do laundry"
		
	 Scenario: I delete the task
	 	Given I have not started on the task, "Do laundry"
		And I am on the dashboard
	 	When I click on "Delete" under the task "Do laundry"
		Then the task "Do laundry" should not be on my list

	Scenario: I attempt to delete task while running it
	 	Given I have started on this task, "Do laundry"
		And I am on the dashboard
	 	When I click on "Delete" under the task "Do laundry"
		Then I should see "Sorry, you cannot delete task while you are working on it"
		And the task "Do laundry" should be on my list
