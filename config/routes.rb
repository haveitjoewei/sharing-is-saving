Rails.application.routes.draw do
  root 'application#home'

  match '*path' => 'application#options_for_mopd', :via => :options

  # Users
  devise_for :users, :controllers => {sessions: 'users/sessions', registrations: 'users/registrations'}
  devise_scope :user do
    get '/profile', to: 'users/registrations#view'
  end
  
  resources :posts, :controller => 'posts' do
    collection do
      get :categories
      get :statuses
    end
  end

  resources :exchanges, :controller => 'exchanges' do
    collection do
      get :statuses
      post :create
    end
    member do
      put :update_status
    end
  end

  resources :activities, :controller => 'activities'

  # get '/activity', to: 'activity/activities#index'

  # get '/exchanges', as: 'exchange_item'
  
  resources :reviews, :controller => 'reviews'  do
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
