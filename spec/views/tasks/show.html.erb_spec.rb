require 'spec_helper'

describe "/tasks/show.html.erb" do
  include TasksHelper
  
  before(:each) do
    @user = stub_model(User,
                       :id => 1,
                       :login => "Dummy login"
                       )
                       
    assigns[:task] = stub_model(Task,
      :description => "value for description",
      :user_id => 1,
      :is_finished => false
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ description/)
    response.should have_text(/1/)
    response.should have_text(/false/)
  end
end
