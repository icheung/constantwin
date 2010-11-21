class TasksController < ApplicationController

  layout 'base'

  before_filter :login_required
  
  # GET /tasks
  # GET /tasks.xml

  #before_filter :update_duration, :only => :show

  def index
    @tasks = @current_user.tasks.find(:all, :conditions => {:is_finished => false}).sort_by {|t| t.created_at}
    @finished_tasks = @current_user.tasks.find(:all, :conditions => {:is_finished => true}).sort_by {|t| t.created_at}
    @tasks.concat(@finished_tasks)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = @current_user.tasks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = @current_user.tasks.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = @current_user.tasks.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = @current_user.tasks.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to(@task) }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = @current_user.tasks.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to(@task) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = @current_user.tasks.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end

  def start_task
    @task = @current_user.tasks.find(params[:id])
    if @task.update_attributes(params[:task]) and @task.update_attribute(:started_at, Time.now)
      @current_user.update_attribute(:is_tasking, true)
      redirect_to(tasks_url)
    else
      format.html { render :action => 'start' }
    end
  end

  def time_left
    @task = @current_user.tasks.find(params[:id])
    if @task.started_at.nil? or @task.is_finished: render :text => '-'
    else
      remaining = @task.duration - Time.at(Time.now - @task.started_at.to_time).min
      if remaining > 0: render :text => remaining
      else render :text => 0
      end
    end
  end

  def add_time
    @task = @current_user.tasks.find(params[:id])

    respond_to do |format|
      format.html
      format.xml { render :xml => task }
    end
  end
  
  def start
    if @current_user.is_tasking
      flash[:error] = "You should be completing only one task at a time!"
      redirect_to(tasks_url)
      
    else
      @task = @current_user.tasks.find(params[:task_id])
      
      respond_to do |format|
        format.html # start.html.erb
        format.xml  { render :xml => @task }
      end
    end
  end

  def update_duration
    @task = @current_user.tasks.find(params[:id])
    @task.update_attributes(params[:task])
    if @task.validate_added_duration
      @task.update_duration
      flash[:notice] = "Successfully added more time!"
      redirect_to :action => "index"
    else
      flash[:error] = "Added time needs to be a valid number between 5 and 60!"
      redirect_to :action => "add_time", :id => params[:id]
    end
  end
  
  def fail
    @task = @current_user.tasks.find(params[:id])
  end
  
  def add_tasks   # Breaking it down.
    # Generalize this later.
    id = params[:id]
    subtask1 = params[:first]
    subtask2 = params[:second]

    task1 = @current_user.tasks.new(:description => subtask1)
    task2 = @current_user.tasks.new(:description => subtask2)
    
    if task1.save and task2.save
      Task.find(params[:id]).delete
      redirect_to(tasks_url)
    else
      [task1, task2].each {|t| t.destroy} # prevents accidental task creation
      flash[:error] = "You need to create at least two subtasks or add more time!"
      redirect_to :action => "fail", :id => id
    end
  end
  
  def finish
    @task = @current_user.tasks.find(params[:id])
    @task.update_attribute(:is_finished, true)
    @current_user.update_attribute(:is_tasking, false)
    render :text => 'Task updated'
  end
  
end
