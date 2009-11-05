require 'redmine'

require 'add_user/hooks/layout_hooks'

# Patches to the Redmine core.
require 'dispatcher'

Dispatcher.to_prepare :redmine_add_user do
  require_dependency 'issue'
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  unless User.included_modules.include? AddUser::Patches::UserPatch
    User.send(:include, AddUser::Patches::UserPatch)
  end
end


Redmine::Plugin.register :redmine_add_user do
  author 'Eric Davis'
  url 'https://projects.littlestreamsoftware.com/projects'
  author_url 'http://www.littlestreamsoftware.com'
  description 'Add User is a plugin that will allow project Members to create new users without having Administrator rights.'

  version '0.1.0'
  requires_redmine :version_or_higher => '0.8.0'

  settings({
             :partial => 'settings/redmine_add_user',
             :default => {
               'roles' => []
             }})

  project_module :designated_contacts do
    permission :add_user, {:designated_contacts => [:new, :create]}
  end
end
