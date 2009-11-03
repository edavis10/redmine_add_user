require 'redmine'

require 'add_user/hooks/layout_hooks'

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
    permission :add_user, {}
  end
end
