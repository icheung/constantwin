Feature: Add more time
  As a user
    I want to add more time
    So that I can finish in a reasonable amount of time

  Background:
    Given a user "foo" exists with email "foo@foo.com" and password "foopassword"
    And I am on the login page
    When I fill in "foo" for "Login"
    And I fill in "foopassword" for "Password"
    And I press "Log in"
    Then I should be on the dashboard
    #And I follow "New task"
    #And I fill in "Description" with "Do laundry"
    #And I press "Create"

  #Scenario: I see the options when time runs out for the task
    #Given I am on the dashboard
    #And time runs out (or Time left is 0)
    #Then I should see "add more time" and "break your original task down"

  Scenario: I click on Add time
    Given the time runs out    
    And I click on “Add time”
    Then I should see a form for adding more time.
  
  Scenario: I added more time
    Given the time runs out    
    And I click on “Add time”
    And I fill in 15 more minutes
    Then I should be on the task timer page
    And there should be 15 more minutes left on my task

