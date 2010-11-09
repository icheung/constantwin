When /^I add a new task called "([^"]*)"$/ do |task_name|
  click_link "New task"
  fill_in "Description", :with => "#{task_name}"
  click_button "Create"
  visit "/"
end
