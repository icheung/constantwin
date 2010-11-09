Given /^I log in as "([^"]*)" with password "([^"]*)"$/ do |user, pass|
  fill_in "Login", :with => "#{user}"
  fill_in "Password", :with => "#{pass}"
  click_button "Log in"
end

When /^I add a new task called "([^"]*)"$/ do |task_name|
  click_link "New task"
  fill_in "Description", :with => "#{task_name}"
  click_button "Create"
  visit "/"
end
