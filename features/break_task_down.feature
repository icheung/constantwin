Feature: Break task down
  As a user
  I want to be able to break down a task
  So that I can finish tasks that are bite-sized chunks of what they used to be

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
    # AND I HAVE STARTED THE TASK "DO LAUNDRY"
    # AND I AM ON THE ITEM VIEW FOR "DO LAUNDRY"
    # AND TIME RUNS OUT

  Scenario: I click on Divide and Conquer     
    When I click on “Divide and Conquer”
    Then I should see a form for breaking down my tasks.
    And I should see two field entries for entering tasks

  Scenario: I broke it down to only one subtask 
    Given I click on “Divide and Conquer”
    When I enter only one subtask
    Then I should see "You need to break down your task"
    And there should be no new tasks
    And I should be on the task timer page for "Do laundry"
   
  Scenario: I broke it down to 2 subtasks
    Given I click on “Divide and Conquer”
    When I enter two subtasks, "Wash clothes" and "Dry clothes"
    Then the "Do laundry" task should be removed from task list
    And "Wash clothes should be on task list
    And "Dry clothes" should be on task list    
    And I should be on the dashboard

  Scenario: I broke it down to 2 subtask, and want to break it more
    Given I click on “Divide and Conquer”
    And I type two subtasks, "Wash clothes" and "Dry clothes"
    When I click on "More"
    Then I should see another entry field

  Scenario: I broke it down to 3 subtasks
    Given I click on “Divide and Conquer”
    And I enter three subtasks, "Wash clothes" and "Dry clothes"
    Then the "Do laundry" task should be removed from task list
    And "Wash clothes should be on task list
    And "Dry clothes" should be on task list
    And "Fold clothes" should be on task list
    And I should be on the dashboard
