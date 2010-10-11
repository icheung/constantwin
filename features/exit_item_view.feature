Feature: Exit Item View
	 As a user
	 I want to be able to exit from this gnarly task view
	 So that I can edit tasks again like a boss

	 Background:
		Given I am logged in as "sample@email.com"
		And I have a task with description "Do laundry"
		And I have started the task "Do laundry"
		

	 Scenario: I exit item view while doing a task
	 	Given I am on the task timer page for "Do laundry"
		When I click on "Back to dashboard"
		Then I should be on the dashboard
		And the task "Do laundry" should not end prematurely
	
	 Scenario: I am going back to item view from dashboard
	 	Given I am on the dashboard
		When I click on "Back to task"  
		Then I should be on the task timer page for "Do laundry"

	 Scenario: I attempt to exit item view right after time runs out
	 	Given I am on the task timer page for "Do laundry"
		And the time runs out
		When I click on "Back to dashboard"
		Then I should see "Please choose what to do with your task first"
		And I should be on the on the task timer page for "Do laundry"