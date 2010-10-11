Feature: Logout
	 As a user
	 I want to be able to log out of ‘Constant Win’
	 So that I can leave the application
	 
	 Background:
		Given I am logged in as "sample@email.com"

	 Scenario: Log out
	 	When I click on "Log out"
		Then I should be on the homepage
		And I should be logged out