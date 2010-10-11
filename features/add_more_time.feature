Feature: Add more time
	 As a user
	 I want to add more time
	 So that I can complete a task that I think I can finish in a reasonable amount of time

	 Background:
		Given I am logged in as "sample@email.com"
		And I have a task with description "Do laundry"
		And I am in the middle of that task
		And I am on the task timer page for "Do laundry"

	 Scenario: I see the options when time runs out for the task
	 	When the time runs out
		Then I should see "Add time", "Divide and Conquer", and "Delegate task to friend"

	 Scenario: I click on Add time
	 	Given the time runs out		 
		And I click on “Add time”
		Then I should see a form for adding more time.
	
	 Scenario: I added more time
	 	Given the time runs out		 
		And I click on “Add time”
		And I fill in 15 more minutes
		Then I should still be on the task timer page
		And there should be 15 more minutes left on my task

