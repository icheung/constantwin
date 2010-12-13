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
    And I add a new task called "Do laundry"
    And I go to the dashboard
    Then I should be on the dashboard
    And I should see "Do laundry"
    
  Scenario: Delete a task
    Given I am on the dashboard
    And I should see "Do laundry"
    When I follow "Delete task"
    #And I press "OK"  (javascript doesn't work with webrat)
    #Then I should be on the dashboard (again, js + webrat = :/ )
    Then I should not see "Do laundry"
  
  Scenario: Delete a duplicate task
    Given I am on the dashboard
    And I should see "Do laundry"
    And I add a new task called "Do laundry"
    And I go to the dashboard
    When I follow "Delete task"
    Then I should see "Do laundry"
    When I follow "Delete task"
    Then I should not see "Do laundry"
    
  Scenario: Delete a task that is running
    Given I am on the dashboard
    And I should see "Do laundry"
    And I follow "Start"
    And I press "Start"
    When I follow "Delete task"
    Then I should not see "Do laundry"
