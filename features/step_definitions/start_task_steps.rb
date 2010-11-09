#Scenario: I start the task
#	Given I am on the dashboard
#	When I press “Start” #for "Do laundry"
#	Then I should be on the task timer page
#	And I should see "Do laundry"
#	And I should see a timer entry field
	

Then /^I should see a timer entry field$/ do
  #response.should contain("#task_duration")
  response.should have_selector("#task_duration")  
end

When /^I start timing "([^\"]*)"$/ do |id|
  within("table") do |context|
    context.click_link("Start")
  end
end