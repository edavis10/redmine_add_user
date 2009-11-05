require File.dirname(__FILE__) + '/../../../../test_helper'

class AddUser::Patches::UserPatchTest < ActiveSupport::TestCase
  def valid_user_attributes
    {
      :firstname => 'Abe',
      :lastname => 'Gabby',
      :mail => 'abe.gabby@gmail.com'
    }
  end
  
  context "#new_designated_contact" do
    setup do
      setup_anonymous_role
      setup_non_member_role
      setup_plugin_configuration
      @project = Project.generate!
    end

    should "generate a new user" do
      user = User.new_designated_contact(@project, valid_user_attributes)

      assert_kind_of User, user
      assert user.new_record?, "User is not a new record"
    end

    should "set the login to the email address" do
      user = User.new_designated_contact(@project, valid_user_attributes)

      assert_equal 'abe.gabby@gmail.com', user.login
    end

    should "trim the login to fit in 30 characters" do
      user = User.new_designated_contact(@project, valid_user_attributes.merge({:mail => 'abe.gabby@areallylongdomainname.com'}))

      assert_equal 'abe.gabby@areallylongdomainnam', user.login
      assert user.valid?, user.errors.full_messages

    end

    should "set the password to a secure random value" do
      user = User.new_designated_contact(@project, valid_user_attributes)

      assert user.password.present?
      assert user.password_confirmation.present?
    end

    should "give the user membership to the project, using the configured roles" do
      user = User.new_designated_contact(@project, valid_user_attributes)

      assert_equal 1, user.members.length, "User does not have a membership setup"
      assert_contains user.members.collect(&:project).flatten, @project
      assert_equal 2, user.members.collect(&:roles).flatten.length, "User does not have roles setup"
      
      user.members.collect(&:roles).flatten.each do |role|
        assert_contains @configured_roles, role
      end
    end

  end
end
