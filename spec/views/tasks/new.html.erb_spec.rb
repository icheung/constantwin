require 'spec_helper'

describe "/tasks/new.html.erb" do
  include TasksHelper

  before(:each) do
    assigns[:task] = stub_model(Task,
      :new_record? => true,
      :description => "value for description",
      :user_id => 1,
      :is_finished => false
    )
  end

  it "renders new task form" do
    render

    response.should have_tag("form[action=?][method=post]", tasks_path) do
      with_tag("input#task_description[name=?]", "task[description]")
      #with_tag("input#task_owner[name=?]", "task[owner]")
      #with_tag("input#task_is_finished[name=?]", "task[is_finished]")
    end
  end
end
