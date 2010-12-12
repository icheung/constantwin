When /^I add a new task called "([^"]*)"$/ do |task_name|
  fill_in "task_description", :with => "#{task_name}"
  click_button "+"
end
