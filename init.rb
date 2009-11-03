require 'redmine'

Redmine::Plugin.register :redmine_add_user do
  author 'Eric Davis'
  url 'https://projects.littlestreamsoftware.com/projects'
  author_url 'http://www.littlestreamsoftware.com'
  description 'Add User is a plugin that will allow project Members to create new users without having Administrator rights.'

  version '0.1.0'
  requires_redmine :version_or_higher => '0.8.0'
end
