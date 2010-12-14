require 'spec_helper'

describe TasksController do
  integrate_views

  # COPIED THIS CODE FROM ONLINE, SUPPOSED TO SET UP USER SESSION FOR ACCESSING TASKS ACTIONS, NOT SURE IF IT ACTUALLY DOES THAT
  before (:each) do
    @current_user = stub_model(User, :id => 1)

    target = controller rescue template
    target.instance_variable_set '@current_user', @current_user

    @task_stubs = {:is_finished => false,
      :started_at => nil,
      :description => "Sample Description",
      :user_id => 1,
      :associated_date => 2.days.ago,
      :duration => 5,
      :paused_at => nil
    }
    @task = mock_task

    Task.stub!(:find).and_return(@task)
  end
  
  def mock_task(stubs={})
    @task_stubs.merge(stubs)
    @mock_task = mock_model(Task, @task_stubs)
  end
  
  describe "GET index" do
    it "assigns all tasks as @tasks" do
      controller.stub!(:get_sorted_list_of_tasks).and_return([@task])
      get :index
      assigns[:tasks].should == [@task]
    end
  end

  describe "GET show" do
    it "assigns the requested task as @task" do
      @task.stub!(:user).and_return(@current_user)
      get :show, :id => "37"
      assigns[:task].should equal(@task)
    end
  end

  describe "GET new" do
    it "assigns a new task as @task" do
      Task.stub(:new).and_return(@task)
      get :new
      assigns[:task].should equal(@task)
    end
  end

  describe "GET edit" do
    it "assigns the requested task as @task" do
      get :edit, :id => "37"
      assigns[:task].should equal(@task)
    end
  end
  
  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created task as @task" do
        @task = mock_task(:save => true)
        @task.stub!(:save).and_return(true)
        Task.stub!(:new).and_return(@task)
        post :create, :task => {:these => 'params'}
        assigns[:task].should equal(@task)
      end

      it "redirects to index after task creation" do
        @task = mock_task(:save => true)
        @task.stub!(:save).and_return(true)
        Task.stub!(:new).and_return(@task)
        post :create, :task => {}
        response.should redirect_to(tasks_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved task as @task" do
        @task = mock_task(:save => false)
        @task.stub!(:save).and_return(false)
        Task.stub(:new).with({'these' => 'params'}).and_return(@task)
        post :create, :task => {:these => 'params'}
        assigns[:task].should equal(@task)
      end

      it "re-renders the 'new' template" do
        @task = mock_task(:save => false)
        @task.stub!(:save).and_return(false)
        Task.stub(:new).and_return(@task)
        post :create, :task => {}
        response.should render_template('new')
      end
    end
  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested task" do
        Task.should_receive(:find).and_return(@task)
        @task.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :task => {:these => 'params'}
      end

      it "assigns the requested task as @task" do
        @task = mock_task(:update_attributes => true)
        @task.stub!(:update_attributes).and_return(true)
        Task.stub!(:find).and_return(@task)
        put :update, :id => "1"
        assigns[:task].should equal(@task)
      end

      it "redirects to the task" do
        @task = mock_task(:update_attributes => true)
        @task.stub!(:update_attributes).and_return(true)
        Task.stub!(:find).and_return(@task)
        put :update, :id => "1"
        response.should redirect_to(task_url(@task))
      end
    end

    describe "with invalid params" do
      it "updates the requested task" do
        Task.should_receive(:find).and_return(@task)
        @task.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :task => {:these => 'params'}
      end

      it "assigns the task as @task" do
        @task = mock_task(:update_attributes => false)
        @task.stub!(:update_attributes).and_return(false)
        Task.stub!(:find).and_return(@task)
        put :update, :id => "1"
        assigns[:task].should equal(@task)
      end

      it "re-renders the 'edit' template" do
        @task = mock_task(:update_attributes => false)
        @task.stub!(:update_attributes).and_return(false)
        Task.stub!(:find).and_return(@task)
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested task" do
      Task.should_receive(:find).and_return(@task)
      @task.stub!(:active_task).and_return(false)
      @task.should_receive(:destroy)
      delete :destroy, :id => "37"
      response.should redirect_to(tasks_url)
    end

    it "redirects to the tasks list" do
      @task = mock_task(:destroy => true)
      @task.stub!(:active_task).and_return(false)
      @task.stub!(:destroy).and_return(true)
      Task.stub!(:find).and_return(@task)
      delete :destroy, :id => "1"
      response.should redirect_to(tasks_url)
    end
  end
  
  describe "when starting a task" do
    it "should update attributes" do

    end
    
    it "should take the user to the start task page" do
      @current_user.stub!(:is_tasking).and_return(false)
      get :start, :task_id => "1"
      assigns[:task].should equal(@task)
      response.should render_template("tasks/start")
    end

    it "should not allow multitasking" do
      @current_user.stub!(:is_tasking).and_return(true)
      get :start, :task_id => "1"
      response.should redirect_to(tasks_url)
    end
  end
=begin
  #describe "when adding time to a task" do
    #it "should be funky funky fresh" do
      #tasks(:one).description.should == "funky"
    #end
  #end
  #
  
  describe "when finishing a task" do
    it "should update the time_left field to ''" do
      Task.stub(:find).and_return(@task)
      @task.stub!(:update_attribute).and_return(true)
      @task.should_receive(:update_attribute).with({'these' => 'params'})
      put :finish, :id => "37", :task => {:these => 'params'}
    end
  end
=end
end
