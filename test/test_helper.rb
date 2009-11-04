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
end

# Shoulda
class Test::Unit::TestCase
  def self.should_render_404
    should_respond_with :not_found
    should_render_template 'common/404'
  end
end
