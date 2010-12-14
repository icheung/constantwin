require 'spec_helper'

describe "/tasks/index.html.erb" do
  include TasksHelper

  before(:each) do
    assigns[:tasks] = [
      stub_model(Task,
        :description => "value for description",
        :user_id => 1,
        :is_finished => false,
        :paused_at => nil
      ),
      stub_model(Task,
        :description => "value for description",
        :user_id => 1,
        :is_finished => false,
        :paused_at => nil
      )
    ]
  end

  it "renders a list of tasks" do
    render
    response.should have_tag("tr>td", "value for description".to_s, 2)

    # because we removed task ID and is_finished flag from views, these tests are no longer needed
    #response.should have_tag("tr>td", 1.to_s, 2)
    #response.should have_tag("tr>td", false.to_s, 2)
  end
end
