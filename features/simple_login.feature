Feature: Simplest login test ever
  As a user
    I want to be able to login to constant win
    So that I can begin winning

	@wip
	Scenario: Testing login
		Given the following user record
		 | login | password    |
		 | foo   | foopassword |
		And I am on the login page
		When I login as "foo" with password "foopassword"
		Then show me the page
		Then I should be on the dashboard
		Then show me the page