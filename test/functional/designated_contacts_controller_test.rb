require 'test_helper'

class DesignatedContactsControllerTest < ActionController::TestCase
  context "routing" do
    should_route :get, "/projects/testingroutes/designated_contacts/new", { :action => :new, :project_id => 'testingroutes' }
    should_route :post, "/projects/testingroutes/designated_contacts", { :action => :create, :project_id => 'testingroutes' }
  end

  should_have_before_filter :find_project
  should_have_before_filter :authorize

  context "on GET to :new" do
    setup do
      setup_anonymous_role
      @project = Project.generate!
      generate_user_and_login_for_project(@project)

      get :new, :project_id => @project
    end

    should_respond_with :success
    should_assign_to :user
    should_render_template :new
  end

  context "on POST to :create" do
    setup do
      setup_anonymous_role
      @project = Project.generate!
      generate_user_and_login_for_project(@project)

      post :create, :user => {}, :project_id => @project
    end

    should_assign_to :user
    should_redirect_to("the project overview") { "/projects/#{@project}" }
    should_set_the_flash_to(/Successful creation/i)

    should "create a user"
    should "add the new user as a Member"
    should "email the user their account information"
  end
end
