Given /^I sign up as "([^"]*)" with email "([^"]*)" and password "([^"]*)"$/ do |user, email, pass|
  visit "/signup"
  fill_in "Login", :with => "#{user}"
  fill_in "Email", :with => "#{email}"
  fill_in "Password", :with => "#{pass}"
  fill_in "Confirm Password", :with => "#{pass}"
  click_button "Sign up"

  # Then manually edit database
  user = User.find(:all, :conditions => {:email => "test@test.com"})
  user[0].activated_at = Time.now
  user[0].save
end

Given /^I log in as "([^"]*)" with password "([^"]*)"$/ do |user, pass|
  fill_in "Login", :with => "#{user}"
  fill_in "Password", :with => "#{pass}"
  click_button "Log in"
end
