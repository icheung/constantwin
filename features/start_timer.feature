Feature: Set timer for task
  As a user
  I want to be able to set a timer for a task
  So that I am motivated to complete task on time

  Background:
    Given I am logged in as "sample@email.com"
    And I am on the dashboard
    When I follow "New task"
    And I fill in "Description" with "Do laundry"
    And I press "Create"

  Scenario: I set the timer for task
    Given I click “Start” #for "Do laundry"
    And I should be on the task timer page #for "Do laundry"
    When I enter "15" minutes in the timer entry field
    Then I should have "15" minutes to complete my task

  Scenario: I set too little time
    Given I click “Start” #for "Do laundry"
    And I should be on the task timer page #for "Do laundry"
    When I enter "5" minutes in the timer entry field
    Then I should see "Time should be a minimum of 15 minutes"
    And the task should not be started
