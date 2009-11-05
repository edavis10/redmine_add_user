module AddUser
  module Hooks
    class LayoutHooks < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(context = { })
        stylesheet_link_tag "redmine_add_user.css", :plugin => "redmine_add_user", :media => 'all'
      end

      def view_layouts_base_sidebar(context={})
        return '' unless context[:project]
        return '' unless context[:project].module_enabled? 'designated_contacts'

        returning '' do |response|
          response << content_tag(:h3, l(:add_user_text_contacts))
          if User.current.allowed_to?(:add_designated_contact, context[:project])
            response << link_to(l(:add_user_text_add_new_designated_contact), {:controller => 'designated_contacts', :action => 'new', :project_id => context[:project]}, :class => 'new-designated-contact')
          end
          response << content_tag(:ul, selected_users(context[:project]).collect {|user| user_item(user) }, :id => 'designated_contacts')
        end
        
      end
      
      private

      # Returns the users who are selected from the plugin
      # configuration (via their Roles)
      def selected_users(project)
        members = if Setting.plugin_redmine_add_user['roles'].empty?
          project.members # All members
        else
          project.members.all(:include => :roles).select do |member|
            member.role_ids.any? {|role_id| Setting.plugin_redmine_add_user['roles'].include? role_id.to_s}
          end
        end

        members.collect(&:user).compact
      end
      
      def user_item(user)
        html = ''
        html << content_tag(:span, link_to_user(user), :class => 'name')
        html << content_tag(:span, "#{l(:label_last_login)}: #{last_login_string(user)}", :class => 'last-login')

        return content_tag(:li, html)

      end

      def last_login_string(user)
        if user.last_login_on.present?
          format_time(user.last_login_on)
        else
          l(:label_none)
        end
      end
    end
  end
end
