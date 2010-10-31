Feature: Delete a task
  As a user
  I want to be able to delete a task from my list
  So that I can remove tasks I don’t want from the list

  Background:
    #Given I am logged in as "sample@email.com"
    Given I am on the dashboard
    And I follow "New task"
    And I fill in "Description" with "Do laundry"
    And I press "Create"
    
  Scenario: I delete the task
    Given I am on the dashboard
    And I see "Do laundry"
    When I click "Delete"
    And I press "OK"
    Then I should not see "Do laundry"
    
  # Scenario: Attempt to delete a duplicate task
