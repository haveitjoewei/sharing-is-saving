Rails.application.routes.draw do
  root 'application#home'

  # connect ':action', :controller => 'static'
  # apipie
  match '*path' => 'application#options_for_mopd', :via => :options

  # map.connect '*path', 
  #           :controller => 'application', 
  #           :action => 'options_for_mopd', 
            # :conditions => {:method => :options}

  # DEVISE
  devise_for :users, :controllers => {sessions: 'users/sessions', registrations: 'users/registrations'}  
  # devise_for :users, skip: [:sessions, :registrations]

  # devise_scope :user do
  #   # Sessions Controller
  #   post '/users/sign_in', to: 'users/sessions#create', as: 'user_session'
  #   delete '/users/sign_out', to: 'users/sessions#destroy', as: 'destroy_user_session'

  #   # Registrations Controller
  #   post '/users', to: 'users/registrations#create', as: 'user_registration'
  #   put '/users/update', to: 'users/registrations#update_user', as: 'user_update'

  # end

  resources :posts, :controller => 'posts' do
    collection do
      get :categories
      get :statuses
    end
  end

  resources :exchanges, :controller => 'exchanges' do
    collection do
      get :statuses
    end
    member do
      put :update_status
    end
  end

  get '/activity', to: 'activity/activities#index'
  
  resources :reviews, :controller => 'reviews/review'  do
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
