class DesignatedContactsController < ApplicationController
  # GET /designated_contacts
  # GET /designated_contacts.xml
  def index
    @designated_contacts = DesignatedContact.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @designated_contacts }
    end
  end

  # GET /designated_contacts/1
  # GET /designated_contacts/1.xml
  def show
    @designated_contact = DesignatedContact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @designated_contact }
    end
  end

  # GET /designated_contacts/new
  # GET /designated_contacts/new.xml
  def new
    @designated_contact = DesignatedContact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @designated_contact }
    end
  end

  # GET /designated_contacts/1/edit
  def edit
    @designated_contact = DesignatedContact.find(params[:id])
  end

  # POST /designated_contacts
  # POST /designated_contacts.xml
  def create
    @designated_contact = DesignatedContact.new(params[:designated_contact])

    respond_to do |format|
      if @designated_contact.save
        flash[:notice] = 'DesignatedContact was successfully created.'
        format.html { redirect_to(@designated_contact) }
        format.xml  { render :xml => @designated_contact, :status => :created, :location => @designated_contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @designated_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /designated_contacts/1
  # PUT /designated_contacts/1.xml
  def update
    @designated_contact = DesignatedContact.find(params[:id])

    respond_to do |format|
      if @designated_contact.update_attributes(params[:designated_contact])
        flash[:notice] = 'DesignatedContact was successfully updated.'
        format.html { redirect_to(@designated_contact) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @designated_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /designated_contacts/1
  # DELETE /designated_contacts/1.xml
  def destroy
    @designated_contact = DesignatedContact.find(params[:id])
    @designated_contact.destroy

    respond_to do |format|
      format.html { redirect_to(designated_contacts_url) }
      format.xml  { head :ok }
    end
  end
end
