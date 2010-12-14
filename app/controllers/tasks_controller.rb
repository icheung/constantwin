class TasksController < ApplicationController

  layout 'base'

  before_filter :login_required
  
  # GET /tasks
  # GET /tasks.xml

  #before_filter :update_duration, :only => :show

  def index
    @tasks = get_sorted_list_of_tasks
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # easier for rspec testing
  def get_sorted_list_of_tasks
    tasks = @current_user.tasks.find(:all, :conditions => {:is_finished => false, :active_task => true})
    unstarted_tasks = @current_user.tasks.find(:all, :conditions => {:is_finished => false, :started_at => nil}).sort_by {|t| t.created_at}
    finished_tasks = @current_user.tasks.find(:all, :conditions => {:is_finished => true}).sort_by {|t| t.created_at}

    tasks.concat(unstarted_tasks).concat(finished_tasks)
    return tasks
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
        format.html {
          flash[:notice] = "Task successfully added"
          redirect_to :action => "index"
        }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
        format.js
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
        format.js {
          #flash[:notice] = 'Task updated'
          render :text => 'Task successfully updated'
        }
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
    if @task.active_task
      current_user.update_attribute(:is_tasking, false)
    end
    @task.destroy
    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end

  def start_task # Actually start the task
    @task = @current_user.tasks.find(params[:id])
    if @task.update_attributes(params[:task]) && @task.update_attribute(:started_at, Time.now) && @task.update_attribute(:active_task, true)
      set_user_tasking_mode_on      
      redirect_to(tasks_url)
    else
      # "Redirect" to start page for the task
      format.html { render :action => 'start' }
    end
  end



  def time_left
    @task = @current_user.tasks.find(params[:id])
    if @task.started_at.nil? or @task.is_finished: render :text => '-'
    else
      if @task.paused_at.nil?
        time_remaining = Time.at(Time.now - @task.started_at.to_time)
      else
        time_remaining = Time.at(@task.paused_at.to_time - @task.started_at.to_time)
      end
      remaining = @task.duration - time_remaining.min
      seconds = 59 - time_remaining.sec
      seconds = seconds >= 10 ? seconds.to_s : "0#{seconds.to_s}"
      time = "#{remaining-1}:#{seconds}"
      if remaining > 0: render :text => time
      else render :text => "0:00"
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
  
  def pause
    @task = @current_user.tasks.find(params[:id])
    logger.debug "ZOMG WE HAVE STOPPED TIME !!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    paused_time = Time.now
    logger.debug "paused time: #{paused_time}"
    @task.update_paused_time(paused_time)    
  end
  
  def resume
    # get the time task was paused
    # get the current time and take the difference
    # total_paused_duration = Time.at(Time.now - @task.paused_at.to_time)
    # add the difference to the task
    # @task.update_added_duration(paused_time)
    @task = @current_user.tasks.find(params[:id])    
    logger.debug "ZOMG IT'S TIME TO RESUME TIME !!!!!!!!!!!!!!!!!!!!!!!!!!!!!"    
    resumed_time = Time.now    
    logger.debug "resumed time: #{resumed_time}"
    @task.resume_time(resumed_time)
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
    @task.clear_duration
    @task.paused_at = nil
  end
  
  def add_tasks   # Breaking tasks down.
    # First set user to non-tasking mode, since we just finished failing task
    set_user_tasking_mode_off
    
    associated_date = params[:associated_date]
    subtasks = [ params[:first], params[:second] ]
    params[:third] ? subtasks << params[:third] : nil
    params[:fourth] ? subtasks << params[:fourth] : nil
    params[:fifth] ? subtasks << params[:fifth] : nil
    
    created_tasks = Array.new
    save_failed = false
    subtasks.each do |subtask|
      puts subtask
      created_tasks << @current_user.tasks.new(:description => subtask, :associated_date => associated_date)
      if not created_tasks[-1].save
        save_failed = true
        created_tasks.each { |t| t.destroy }
        break
      end
    end
    
    if save_failed
      flash[:error] = "You need to create at least two subtasks (and not leave fields blank) or add more time!"
      redirect_to :action => "fail", :id => params[:id]
    else
      Task.find(params[:id]).delete
      redirect_to(tasks_url)
    end
  end
  
  def finish
    @task = @current_user.tasks.find(params[:id])
    @task.update_attribute(:is_finished, true)

    set_user_tasking_mode_off
    
    render :text => 'Task updated'
  end
  
  def ondate
    date = params[:date].to_i
    y = date/10000
    m = (date-y*10000)/100
    d = date-y*10000-m*100
    nextDay = Date.new(y,m,d) + 1
    task_list = @current_user.tasks
    tasks = task_list.find_all{|t| (t.associated_date.to_date <= nextDay) and (t.associated_date.to_date >= nextDay - 1)}
    task_ids = []
    tasks.each {|t| task_ids << t.id}
    #if @tasks.length == 0
    #  render :text => 'No tasks found on ' + y.to_s + '-' + m.to_s + '-' + d.to_s
    #else
    #  render :partial => 'task_list'
    #end
    render :text => task_ids.join(' ')
  end

  def task_list_partial
    @tasks = get_sorted_list_of_tasks
    render :partial => 'task_list'
  end

  # Because Facebook users don't have password and email in the user model,
  # validations fail on save, so this is a workaround
  def set_user_tasking_mode_on
    if @current_user.facebook_user?
      @current_user.is_tasking = true
      @current_user.save(false)
    else
      @current_user.update_attribute(:is_tasking, true)
    end
  end

  def set_user_tasking_mode_off
    if @current_user.facebook_user?
      @current_user.is_tasking = false
      @current_user.save(false)
    else
      @current_user.update_attribute(:is_tasking, false)
    end
  end
  
end
