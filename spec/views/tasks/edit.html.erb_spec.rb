require 'spec_helper'

describe "/tasks/edit.html.erb" do
  include TasksHelper

  before(:each) do
    assigns[:task] = @task = stub_model(Task,
      :new_record? => false,
      :description => "value for description",
      :user_id => 1,
      :is_finished => false
    )
  end

  it "renders the edit task form" do
    render

    response.should have_tag("form[action=#{task_path(@task)}][method=post]") do
      with_tag('input#task_description[name=?]', "task[description]")
      #with_tag('input#task_user_id[name=?]', "task[user_id]")
      #with_tag('input#task_is_finished[name=?]', "task[is_finished]")
    end
  end
end
