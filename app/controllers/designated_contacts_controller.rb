class DesignatedContactsController < ApplicationController
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
    @user = User.new(params[:designated_contact])

    respond_to do |format|
      if @user.save
        flash[:notice] = l(:notice_successful_create)
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
end
