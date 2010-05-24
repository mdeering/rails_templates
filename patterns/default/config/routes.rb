ActionController::Routing::Routes.draw do |map|

  map.signup 'signup', :controller => :users, :action => :new,    :conditions => { :method => :get }
  map.signup 'signup', :controller => :users, :action => :create, :conditions => { :method => :post }

  map.login 'login', :controller => :user_sessions, :action => :new,    :conditions => { :method => :get }
  map.login 'login', :controller => :user_sessions, :action => :create, :conditions => { :method => :post }

  map.logout 'logout', :controller => :user_sessions, :action => :destroy, :conditions => { :method => :get }

  map.resources :users, :only => [ :show ]

  map.namespace :nervecenter do |nervecenter|
    nervecenter.root :controller => :users
  end

  map.root :controller => 'site', :action => 'show', :path => []

end
