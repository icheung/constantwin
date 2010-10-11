Feature: Login
	 As a user
	 I want to login to 'constant win'
	 So that I can begin creating a to-do list
	 
	 Background:
		Given my email is "sample@email.com"
		And I am not logged in		

	 Scenario: Attempt to Register	 	
		Given I am on the homepage
	 	When I click on "Register"
		Then I should be on the register account page

	 Scenario: Register new account with unique email
		   Given I am on the register account page
		   And there is no account registered to "sample@email.com"
		   And I entered all fields in the form
		   When I submit my form
		   Then I should have an account registered with my email

	 Scenario: Register new account with non-unique email
	 	   Given I am on the register account page
	 	   And there is already an account registered to "sample@email.com"
		   And I entered all fields in the form
		   When I submit my form
		   Then I should see "Error: Email address already exists." 
	 	   
	 Scenario: Log in with unregistered email
	 	   Given I am on the homepage
		   And there is no account registered to "sample@email.com"
		   When I attempt to sign in
		   Then I should see "Error: Wrong Email/Password."
		   And I should not be signed in
		   
   	 Scenario: Log in with wrong password
	 	   Given I am on the homepage
		   And there is already an account registered to "sample@email.com"
		   And my password entry is wrong
		   When I attempt to sign in
		   Then I should see "Error: Wrong Email/Password."
		   And I should not be signed in

	 Scenario: Log in with registered email
	 	   Given I am on the homepage
		   And there is already an account registered to "sample@email.com"
		   And my password entry is correct
		   When I attempt to sign in
		   Then I should be signed in
		   And I should see my dashboard

