module AddUser
  module Patches
    module UserPatch
      def self.included(base) # :nodoc:
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable # Send unloadable so it will not be unloaded in development
        end

      end
      
      module ClassMethods
        def new_designated_contact(project, user_attributes)
          u = new(user_attributes)
          u.login = u.mail.slice(0,30)

          u.password = ActiveSupport::SecureRandom.hex(10)
          u.password_confirmation = u.password

          if Setting.plugin_redmine_add_user['roles']
            u.members << Member.new(:project => project,
                                    :principal => u,
                                    :roles => Role.find_all_by_id(Setting.plugin_redmine_add_user['roles']))
          end
          u
        end
      end
      
      module InstanceMethods
      end    
    end
  end
end
