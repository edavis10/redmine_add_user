class DesignatedContactsController < ApplicationController
  unloadable
  before_filter :find_project
  before_filter :authorize
  
  # GET /projects/:project_id/designated_contacts/new
  # GET /projects/:project_id/designated_contacts/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # POST /projects/:project_id/designated_contacts
  # POST /projects/:project_id/designated_contacts.xml
  def create
    @user = User.new_designated_contact(@project, params[:user])

    respond_to do |format|
      if @user.save
        Mailer.deliver_account_information(@user, @user.password) if params[:send_information]
        flash[:notice] = l(:notice_successful_create)
        format.html { redirect_to(:controller => 'projects', :action => 'show', :id => @project) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  private
  
  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
