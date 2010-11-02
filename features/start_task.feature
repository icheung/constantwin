Feature: Start task
  As a user
    I want to be able to start one of the tasks from my list of tasks
    So that I can begin working on that task

  Background:
    #Given I am logged in as "sample@email.com"
    Given I am on the dashboard
    And I follow "New task"
    And I fill in "Description" with "Do laundry"
    And I press "Create"
    And I follow "Back"
    And I follow "New task"
    And I fill in "Description" with "Do homework"
    And I press "Create"

  Scenario: I start the task
    Given I am on the dashboard
    When I press “Start” for "Do laundry"
    Then I should be on the task timer page
    And I should see "Do laundry"
    And I should see a timer entry field

  Scenario: I start a task while in the middle of another task
    Given I am on the dashboard
    When I click “Start” #for "Do homework"
    #Given I am on the task timer page
    #And I see "Do laundry"
    #When I go back to the dashboard
    #And I click “Start” #for "Do homework"
    Then I should see "Error: Finish your present task first"
    And the second task should not be started
