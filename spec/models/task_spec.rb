require 'spec_helper'

describe Task do
  before(:each) do
    @valid_task_attributes = {
      :description => "value for description",
      :duration => Time.now,
      :owner => 1,
      :is_finished => false,
      :started_at => nil
    }
  end

  it "should create a new instance given valid attributes" do
    Task.create(@valid_task_attributes).should be_true
  end

  it "should not create a task instance without a description" do
    @empty_description = @valid_task_attributes
    @empty_description[:description] = nil
    Task.new(@empty_description).should_not be_valid
  end

  it "should not create a task instance without an owner" do
    @no_owner = @valid_task_attributes
    @no_owner[:owner] = nil
    Task.new(@no_owner).should_not be_valid
  end

  it "should not create a task instance without a duration" do
    @no_time_set = @valid_task_attributes
    @no_time_set[:duration] = nil
    Task.new(@no_time_set).should_not be_valid
  end

  it "should not create a task instance with a duration of less than 5 minutes" do
    @short_time = @valid_task_attributes
    @short_time[:duration] = Time.parse("2000-01-01 0:00 AM")
    Task.new(@short_time).should_not be_valid
  end

  it "should not create a task with 'started_at' already set" do
    @already_started = @valid_task_attributes
    @already_started[:started_at] = Time.parse("2000-01-01 0:00 AM")
    Task.new(@already_started).should_not be_valid
  end

  it "should not create a task instance that is already tagged 'finished'" do
    @finished_already = @valid_task_attributes
    @finished_already[:is_finished] = true
    Task.new(@finished_already).should_not be_valid
  end

  it "should destroy task when user is destroyed" do
      @user = User.create! @valid_user_attributes
      @task = @user.tasks.create! @valid_task_attributes
      task_id = @user.tasks[0].id
      @user.destroy
      lambda {Task.find(task_id)}.should raise_error(ActiveRecord::RecordNotFoundError)
  end

end
