class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.xml

  before_filter :update_duration, :only => :show

  def index
    @tasks = Task.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to(@task, :notice => 'Task was successfully created.') }
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
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to(@task, :notice => 'Task was successfully updated.') }
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
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end

  def start_task
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task]) and @task.update_attribute(:started_at, Time.now)
      redirect_to(tasks_url)
    else
      format.html { render :action => 'start' }
    end
  end

  def time_left
    task = Task.find(params[:id])
    remaining = task.duration - Time.at(Time.now - task.started_at.to_time).min
    if remaining > 0: render :text => remaining
    else render :text => 0
    end
  end

  def add_time
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html
      format.xml { render :xml => task }
    end
  end
  
  def start
    @task = Task.find(params[:task_id])

    respond_to do |format|
      format.html # start.html.erb
      format.xml  { render :xml => @task }
    end
  end

  def update_duration
    @task = Task.find(params[:id])
    @task.duration = @task.duration + @task.added_time
    @task.added_time = 0
    @task.save!
  end
  
  def fail
    @task = Task.find(params[:id])
  end
  
  def add_tasks   # Breaking it down.
    # Generalize this later.
    id = params[:id]
    subtask1 = params[:first]
    subtask2 = params[:second]
    
    task1 = Task.new(:description => subtask1, :duration => 15)
    task2 = Task.new(:description => subtask2, :duration => 15)
    
    if task1.save and task2.save
      redirect_to(tasks_url)
    else
      flash[:error] = "Failed to save subtasks."
      redirect_to :action => "fail", :id => id
    end
  end
  
end
