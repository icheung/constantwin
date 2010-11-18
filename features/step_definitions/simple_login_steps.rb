Given /^the following user record$/ do |table|
  table.hashes.each do |hash|
    Factory(:user, hash)
  end
end

When /^I login as "([^"]*)" with password "([^"]*)"$/ do |username, password|
  fill_in "Login", :with => username
  fill_in "Password", :with => password
  click_button "Log in"
end