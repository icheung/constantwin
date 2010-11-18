#Scenario: I start the task
#	Given I am on the dashboard
#	When I press “Start” #for "Do laundry"
#	Then I should be on the task timer page
#	And I should see "Do laundry"
#	And I should see a timer entry field

#Given /^I am logged in as "([^\"]*)" with password "([^\"]*)"$/ do |user, pass|
  #fill_in "Login", :with => "#{user}"
  #fill_in(field, :with => value)
  #fill_in("login", :with => user)
  #fill_in "Password", :with => "#{pass}"
  #fill_in(field, :with => value)
  #fill_in("password", :with => pass)
  #click_button "Log in"
#end

#Given /^I am logged in as iriswin$/ do
#  user = mock_model(User,
#    :login => "testuser",
#    :email => "testuser@test.com",
#    :name => "testname",
#    :password => "test")
#  ApplicationController.stub!(:current_user).and_return(user)
#end

Then /^I should see a timer entry field$/ do
  #response.should contain("#task_duration")
  response.should have_selector("#task_duration")  
end

#When /^I start timing "([^\"]*)"$/ do |id|
#  within("table") do |context|
#    context.click_link("Start")
#  end
#end

#Given /^I log in as "([^"]*)" with password "([^"]*)"$/ do |user,pass|
  # # create user
  # user = mock_model(User,
  #   :login => "testuser",
  #   :email => "testuser@test.com",
  #   :name => "testname",
  #   :pasword => "test")
  #    @user = User.new(params[:user])
  # #fill_in "Login", :with => "#{user}"
  # #fill_in "Password", :with => "#{pass}"
  # fill_in "Login", :with => user.login
  # fill_in "Password", :with => user.password
  # click_button "Log in"
#end