Feature: Delete a task
  As a user
  I want to be able to delete a task from my list
  So that I can remove tasks I don’t want from the list

  Background:
    Given a user "foo" exists with email "foo@foo.com" and password "foopassword"
    And I am on the login page
    When I fill in "foo" for "Login"
    And I fill in "foopassword" for "Password"
    And I press "Log in"
    Then I should be on the dashboard
    #Then create a new task called "Do laundry"
    
  Scenario: I delete the task
    Given I am on the dashboard
    And I see "Do laundry"
    When I click "Delete"
    And I press "OK"
    Then I should not see "Do laundry"
    
  # Scenario: Attempt to delete a duplicate task
