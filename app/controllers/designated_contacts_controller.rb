class DesignatedContactsController < ApplicationController
  # GET /designated_contacts/new
  # GET /designated_contacts/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # POST /designated_contacts
  # POST /designated_contacts.xml
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
