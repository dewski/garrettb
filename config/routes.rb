GB::Application.routes.draw do |map|
  resources :users
  resource  :user_session
  
  match '/admin', :to => redirect("/admin/dashboard")
  namespace :admin do
    resource  :dashboard
    resources :items
  end

  root :to => 'welcome#index'
end
