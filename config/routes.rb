ActionController::Routing::Routes.draw do |map|
  map.resources :designated_contacts, :path_prefix => '/projects/:project_id', :only => [:new, :create]
end
