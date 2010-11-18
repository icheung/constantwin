Feature: Start task
  As a user
    I want to be able to start one of the tasks from my list of tasks
    So that I can begin working on that task

	@focus
	Scenario: Testing login
		Given the following user record
		 | login | password    |
		 | foo   | foopassword |
		And I am on the login page
		When I login as "foo" with password "foopassword"
		Then show me the page
		Then I should be on the task timer page




