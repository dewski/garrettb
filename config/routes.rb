GB::Application.routes.draw do |map|
  # Sessions
  match '/user_session/new' => redirect('/login')
  match '/login' => 'user_sessions#new'
  match '/logout' => 'user_sessions#destroy'
  resources :users
  resource  :user_session
  resource  :trip, :as => 'relocation'
  resource  :droplet, :controller => 'droplet'
  
  # Admin
  match '/admin' => redirect('/admin/dashboard')
  namespace :admin do
    resource  :dashboard
    
    resources :items do
        
      collection do
        post :reorder
      end
      
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
    resources :agencies
  end
  
  resources :works, :as => 'work'
  resources :posts, :as => 'blog' do
    resources :comments
  end
  
  resource :contact, :controller => 'contact'
  resource :about, :controller => 'about'
  
  root :to => 'welcome#index'
end