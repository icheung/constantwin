class TasksController < ApplicationController

  before_filter :login_required
  
  # GET /tasks
  # GET /tasks.xml

  #before_filter :update_duration, :only => :show

  def index
    @tasks = Task.find_all_by_user_id(@current_user.id, :conditions => {:is_finished => false}).sort_by {|t| t.created_at}
    @finished_tasks = Task.find_all_by_user_id(@current_user.id, :conditions => {:is_finished => true}).sort_by {|t| t.created_at}
    @tasks.concat(@finished_tasks)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find_by_id_and_user_id(params[:id], @current_user.id)

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
    @task = Task.find_by_id_and_user_id(params[:id], @current_user.id)
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
    @task = Task.find_by_id_and_user_id(params[:id], @current_user.id)

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
    @task = Task.find_by_id_and_user_id(params[:id], @current_user.id)
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end

  def start_task
    @task = Task.find_by_id_and_user_id(params[:id], @current_user.id)
    if @task.update_attributes(params[:task]) and @task.update_attribute(:started_at, Time.now)
      redirect_to(tasks_url)
    else
      format.html { render :action => 'start' }
    end
  end

  def time_left
    task = Task.find_by_id_and_user_id(params[:id], @current_user.id)
    if task.started_at.nil? or task.is_finished: render :text => '-'
    else
      remaining = task.duration - Time.at(Time.now - task.started_at.to_time).min
      if remaining > 0: render :text => remaining
      else render :text => 0
      end
    end
  end

  def add_time
    @task = Task.find_by_id_and_user_id(params[:id], @current_user.id)

    respond_to do |format|
      format.html
      format.xml { render :xml => task }
    end
  end
  
  def start
    @task = Task.find_by_id_and_user_id(params[:task_id], @current_user.id)

    respond_to do |format|
      format.html # start.html.erb
      format.xml  { render :xml => @task }
    end
  end

  def update_duration
    @task = Task.find_by_id_and_user_id(params[:id], @current_user.id)
    @task.update_attributes(params[:task])
    @task.duration += @task.added_time
    @task.added_time = 0
    @task.save

    render :text => "Task duration updated"
    '''
    respond_to do |format|
      if @task.save
        format.html { redirect_to(@task) }
        format.xml  { render :xml => @task, :location => @task }
      else
        format.html { render :action => "add_time" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
    '''
  end
  
<<<<<<< Updated upstream
  def fail
    @task = Task.find_by_id_and_user_id(params[:id], @current_user.id)
=======
  def fail
    @task = Task.find(params[:id], :conditions => {:user_id => @current_user.id})
>>>>>>> Stashed changes
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
    task = Task.find_by_id_and_user_id(params[:id], :user_id => @current_user.id)
    task.update_attribute(:is_finished, true)
    render :text => 'Task updated'
  end
  
end
