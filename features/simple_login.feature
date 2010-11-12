Feature: Simplest login test ever
  As a user
    I want to be able to login to constant win
    So that I can begin winning
    
	@wip
       Scenario: Testing registration
       		 Given I am on the login page
		 Then show me the page


	Scenario: Testing login
#		Given the following user record
#		 | login | password    |
#		 | foo   | foopassword |
		Given a user "foo" exists with email "foo@foo.com" and password "foopassword"
		And I am on the login page
		#When I log in as "foo" with password "foopassword"
		When I fill in "foo" for "Login"
		And I fill in "foopassword" for "Password"
		And I press "Log in"
		#Then I should be on the dashboard
		Then show me the page
