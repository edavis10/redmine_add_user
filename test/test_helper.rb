# Load the normal Rails helper
require File.expand_path(File.dirname(__FILE__) + '/../../../../test/test_helper')

# Ensure that we are using the temporary fixture path
Engines::Testing.set_fixture_path

# Helpers
class Test::Unit::TestCase
  def configure_plugin(fields={})
    Setting.plugin_redmine_add_user = fields.stringify_keys
  end

  def setup_plugin_configuration
    @configured_roles = [Role.generate!, Role.generate!]
    configure_plugin({
                       'roles' => @configured_roles.collect(&:id).collect(&:to_s),
                     })
  end

  def setup_anonymous_role
    @anon_role = Role.generate!
    @anon_role.update_attribute(:builtin, Role::BUILTIN_ANONYMOUS)
  end

  def setup_non_member_role
    @non_member_role = Role.generate!
    @non_member_role.update_attribute(:builtin, Role::BUILTIN_NON_MEMBER)
  end

  def generate_user_and_login_for_project(project, user_attributes={})
    @user = User.generate_with_protected!(user_attributes)
    @role = Role.generate!(:permissions => Redmine::AccessControl.permissions.collect(&:name))
    @member = Member.create(:project => @project, :user => @user, :roles => [@role])
    @request.session[:user_id] = @user.id
  end
end

# Shoulda
class Test::Unit::TestCase
  def self.should_render_404
    should_respond_with :not_found
    should_render_template 'common/404'
  end

  def self.should_have_before_filter(expected_method, options = {})
    should_have_filter('before', expected_method, options)
  end

  def self.should_have_after_filter(expected_method, options = {})
    should_have_filter('after', expected_method, options)
  end

  def self.should_have_filter(filter_type, expected_method, options)
    description = "have #{filter_type}_filter :#{expected_method}"
    description << " with #{options.inspect}" unless options.empty?

    should description do
      klass = "action_controller/filters/#{filter_type}_filter".classify.constantize
      expected = klass.new(:filter, expected_method.to_sym, options)
      assert_equal 1, @controller.class.filter_chain.select { |filter|
        filter.method == expected.method && filter.kind == expected.kind &&
        filter.options == expected.options && filter.class == expected.class
      }.size
    end
  end
end
