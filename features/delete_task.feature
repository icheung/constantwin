Feature: Delete a task
  As a user
  I want to be able to delete a task from my list
  So that I can remove tasks I don’t want from the list

  Background:
    #Given I am logged in as "sample@email.com"
    #And I have a task with description "Do laundry"
    
  Scenario: I delete the task
    Given I am on the dashboard
    And I see "Do laundry"
    When I click "Destroy"
    And I press "OK"
    Then I should not see "Do laundry"

  Scenario: I attempt to delete task while running it
    Given I am on the dashboard
    # and I see a time in the "Time left" column
    When I click on "Destroy" #under the task "Do laundry"
    Then I should see "Sorry, you cannot delete task while you are working on it"
    And I should see "Do laundry"
    
  # Scenario: Attempt to delete a duplicate task
