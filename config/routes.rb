GB::Application.routes.draw do |map|
  # Sessions
  match '/user_session/new' => redirect('/login')
  match '/login' => 'user_sessions#new'
  match '/logout' => 'user_sessions#destroy'
  resources :users
  resource  :user_session
  
  # Admin
  match '/admin' => redirect("/admin/dashboard")
  namespace :admin do
    resource  :dashboard
    
    resources :items do
      
      resources :images do
        member do
          get :crop
        end
        
        collection do
          post :reorder
        end
      end
      
    end
    
    resources :posts do
      resources :comments
    end
    
    resources :categories
    resources :skills
  end
  
  resources :works, :as => 'work'
  resources :posts, :as => 'blog'
  
  match '/about' => 'pages#about', :as => 'about'
  match '/contact' => 'pages#contact', :as => 'contact'
  
  root :to => 'welcome#index'
end