Given /^the following user record$/ do |table|
  table.hashes.each do |hash|
    @testuser = Factory(:user, hash)
  end
end

When /^I login as "([^"]*)" with password "([^"]*)"$/ do |username, password|
  fill_in "Login", :with => @testuser.login
  fill_in "Password", :with => @testuser.password
  click_button "Log in"
end