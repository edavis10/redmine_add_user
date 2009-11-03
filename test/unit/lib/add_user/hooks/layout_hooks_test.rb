require File.dirname(__FILE__) + '/../../../../test_helper'

class AddUser::Hooks::LayoutHooksTest < ActionController::TestCase
  include Redmine::Hook::Helper

  def controller
    @controller ||= WelcomeController.new
    @controller.response ||= ActionController::TestResponse.new
    @controller
  end

  def request
    @request ||= ActionController::TestRequest.new
  end

  def hook(args={})
    call_hook :view_layouts_base_sidebar, args
  end

  context "#view_layouts_base_sidebar" do
    context "with no project" do
      should 'render nothing' do
        assert hook.blank?
      end
    end

    context "with a project with a disabled designated_contacts module" do
      should 'render nothing' do
        @project = Project.generate!
        @project.enabled_modules.find_by_name('designated_contacts').try(:destroy)
        @project.reload
        
        assert hook.blank?
      end
    end

    context "with a project with an active designated_contacts module" do
      setup do
        @project = Project.generate!
        3.times do
          user = User.generate_with_protected!
          @project.members << Member.new(:project => @project, :user => user, :roles => [Role.generate!])
        end

      end

      should "render a header" do
        @response.body = hook
        assert_select 'h3', 'Designated Contacts'
      end

      should "render the list of current members" do
        @response.body = hook
        assert_select 'ul' do
          assert_select 'li', :count => 3 do
            assert_select 'span.name' do
              assert_select 'a'
            end

            assert_select 'span.last-login'
          end
        end
      end

      context "for a user with permission to add a user" do
        should "render the link to add a new user"
      end
    end
  end
end
