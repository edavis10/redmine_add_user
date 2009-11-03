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
          response << content_tag(:ul, context[:project].members.collect {|member| member_item(member) }, :id => 'designated_contacts')
        end
        
      end
      
      private
      
      def member_item(member)
        html = ''
        html << content_tag(:span, link_to_user(member.user), :class => 'name')
        html << content_tag(:span, "#{l(:label_last_login)}: #{last_login_string(member.user)}", :class => 'last-login')

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
