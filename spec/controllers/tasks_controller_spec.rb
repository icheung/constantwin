require 'spec_helper'

describe TasksController do
  integrate_views

  # COPIED THIS CODE FROM ONLINE, SUPPOSED TO SET UP USER SESSION FOR ACCESSING TASKS ACTIONS, NOT SURE IF IT ACTUALLY DOES THAT
  before (:each) do
    @current_user = stub_model(User)
    target = controller rescue template
    target.instance_variable_set '@current_user', @current_user
  end


  
  def mock_task(stubs={})
    @mock_task = mock_model(Task, stubs)
  end
  
  describe "GET index" do
    it "assigns all tasks as @tasks" do
      TasksController.stub(:get_sorted_list_of_tasks).and_return([mock_task])
      get :index
      assert assigns(:tasks)
      assigns.each {|k, v| puts "[#{k} #{v}]"}
      assigns[:tasks].should == [mock_task]
    end
  end

  #TEMPORARILY COMMENTED OUT FOR TESTING PURPOSES
  
=begin
  describe "GET show" do
    it "assigns the requested task as @task" do
      Task.stub(:find).with("37").and_return(mock_task)
      Task.stub(:duration)
      get :show, :id => "37"
      assigns[:task].should equal(mock_task)
    end
  end

  describe "GET new" do
    it "assigns a new task as @task" do
      Task.stub(:new).and_return(mock_task)
      get :new
      assigns[:task].should equal(mock_task)
    end
  end

  describe "GET edit" do
    it "assigns the requested task as @task" do
      Task.stub(:find).with("37").and_return(mock_task)
      get :edit, :id => "37"
      assigns[:task].should equal(mock_task)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created task as @task" do
        Task.stub(:new).with({'these' => 'params'}).and_return(mock_task(:save => true))
        post :create, :task => {:these => 'params'}
        assigns[:task].should equal(mock_task)
      end

      it "redirects to the created task" do
        Task.stub(:new).and_return(mock_task(:save => true))
        post :create, :task => {}
        response.should redirect_to(task_url(mock_task))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved task as @task" do
        Task.stub(:new).with({'these' => 'params'}).and_return(mock_task(:save => false))
        post :create, :task => {:these => 'params'}
        assigns[:task].should equal(mock_task)
      end

      it "re-renders the 'new' template" do
        Task.stub(:new).and_return(mock_task(:save => false))
        post :create, :task => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested task" do
        Task.should_receive(:find).with("37").and_return(mock_task)
        mock_task.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :task => {:these => 'params'}
      end

      it "assigns the requested task as @task" do
        Task.stub(:find).and_return(mock_task(:update_attributes => true))
        put :update, :id => "1"
        assigns[:task].should equal(mock_task)
      end

      it "redirects to the task" do
        Task.stub(:find).and_return(mock_task(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(task_url(mock_task))
      end
    end

    describe "with invalid params" do
      it "updates the requested task" do
        Task.should_receive(:find).with("37").and_return(mock_task)
        mock_task.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :task => {:these => 'params'}
      end

      it "assigns the task as @task" do
        Task.stub(:find).and_return(mock_task(:update_attributes => false))
        put :update, :id => "1"
        assigns[:task].should equal(mock_task)
      end

      it "re-renders the 'edit' template" do
        Task.stub(:find).and_return(mock_task(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested task" do
      Task.should_receive(:find).with("37").and_return(mock_task)
      mock_task.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the tasks list" do
      Task.stub(:find).and_return(mock_task(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(tasks_url)
    end
  end
  
  describe "when starting a task" do
    it "should take the user to the start task page" do
      Task.stub(:find).with("1").and_return(mock_task)
      get :start, :task_id => "1"
      assigns[:task].should equal(mock_task)
      #response.should redirect_to("/tasks/start?task_id=1")
    end
  end

 
  #describe "when adding time to a task" do
    #it "should be funky funky fresh" do
      #tasks(:one).description.should == "funky"
    #end
  #end
  #
  
  #describe "when finishing a task" do
  #  it "should update the time_left field to ''" do
  #    Task.stub(:find).with("37").and_return(mock_task)
  #    mock_task.should_receive(:update_attributes).with({'these' => 'params'})
  #    put :finish, :id => "37", :task => {:these => 'params'}
  #  end
  #end
=end
end
