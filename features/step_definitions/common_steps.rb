Given /^a user "([^"]*)" exists with email "([^"]*)" and password "([^"]*)"$/ do |user, email, pass|
  visit "/signup"
  fill_in "Login", :with => "#{user}"
  fill_in "Email", :with => "#{email}"
  fill_in "Password", :with => "#{pass}"
  fill_in "Confirm Password", :with => "#{pass}"
  click_button "Sign up"

  # Then manually edit database
  user = User.find(:all, :conditions => {:email => email})
  user[0].activated_at = Time.now
  user[0].save
end

Given /^I am logged in with username "([^"]*)" and password "([^"]*)"$/ do |user, pass|
  visit "/session/new"
  fill_in "Login", :with => "#{user}"
  fill_in "Password", :with => "#{pass}"
  click_button "Log in"
end

When /^I log in as "([^"]*)" with password "([^"]*)"$/ do |user, pass|
  fill_in "Login", :with => "#{user}"
  fill_in "Password", :with => "#{pass}"
  click_button "Log in"
end

