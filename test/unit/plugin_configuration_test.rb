require File.dirname(__FILE__) + '/../test_helper'

class PluginConfigurationTest < Test::Unit::TestCase
  context "roles configuration option" do
    should 'exist' do
      assert Setting.plugin_redmine_add_user.keys.include?('roles'), "No key found in: #{Setting.plugin_redmine_add_user.keys}"
    end

    should "default to an empty array" do
      Setting.find_by_name('plugin_redmine_add_user').try(:destroy)
      assert_equal [], Setting['plugin_redmine_add_user']['roles'] # Bypass cache
    end

    should 'allow setting roles' do
      settings = {'roles' => ['1','2']}
      Setting.plugin_redmine_add_user = settings

      assert_equal settings, Setting.plugin_redmine_add_user
    end

  end

end
