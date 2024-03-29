require 'spec_helper'

describe Task do
  before(:each) do
    @valid_task_attributes = {
      :description => "value for description",
      # :duration => Time.now, no need b/c duration not set until task starts
      :user_id => 1,
      :is_finished => false,
      :started_at => nil,
      :added_time => 0
    }

    @valid_user_attributes = {
      :name => "The Boss",
      :login => "theboss",
      :email => "constantwin@email.com",
      :password => "12345abcde",
      :password_confirmation => "12345abcde"
    }
    @user = User.create! @valid_user_attributes
  end

  describe "when creating a new task" do
    it "should create a new instance given valid attributes" do
      Task.create(@valid_task_attributes).should be_true
    end

    it "should not create a task instance without a description" do
      @empty_description = @valid_task_attributes
      @empty_description[:description] = nil
      Task.new(@empty_description).should_not be_valid
    end
    ''' # Removing this test, b/c Task model internally provides a default user_id at the moment
    it "should not create a task instance without an owner" do
      @no_owner = @valid_task_attributes
      @no_owner[:user_id] = nil
      Task.new(@no_owner).should_not be_valid
    end
    '''
    it "should not create a task with 'started_at' already set" do
      @already_started = @valid_task_attributes
      @already_started[:started_at] = Time.now
      Task.new(@already_started).should_not be_valid
    end
    
    it "should not create a task instance that is already tagged 'finished'" do
      @finished_already = @valid_task_attributes
      @finished_already[:is_finished] = true
      Task.new(@finished_already).should_not be_valid
    end
    
    it "should destroy task when user is destroyed" do
      @task = @user.tasks.create! @valid_task_attributes
      task_id = @user.id
      @user.destroy
      lambda {Task.find(task_id)}.should raise_error(::ActiveRecord::RecordNotFound)
    end
    
    it "should be able to create a duplicate task" do
      Task.create(@valid_task_attributes).should be_true
      Task.create(@valid_task_attributes).should be_true
    end
  end

  describe "when starting a task" do
    it "task should not start without given a duration" do
      @no_time_set = @valid_task_attributes
      @no_time_set_task = Task.new(@no_time_set)
      lambda {@no_time_set_task.start}.should raise_error
    end
    it "task duration should not be given a duration of less than 5 minutes" do
      @short_time = @valid_task_attributes
      @short_time[:duration] = 5
      @short_time_task = Task.new(@short_time)
      lambda {@short_time_task.start}.should raise_error
    end
  end

  describe "when adding time to a task" do
    it "should initialize the add_time field to 0" do
      @dummy_task = Task.new @valid_task_attributes
      @dummy_task.added_time.should == 0
    end

    it "should add 5 minutes when the add_time field is set to 5" do
      @dummy_task = Task.new @valid_task_attributes
      @dummy_task.duration = 10
      @dummy_task.added_time = 5
      @dummy_task.update_duration
      @dummy_task.duration.should == 15
    end
  end
end
