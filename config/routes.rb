Rails.application.routes.draw do
  resources :email_templates
  root 'static#index'

  get 'static/index', as: 'home'

  get    'profile', to: 'users#show'
  get    'signup', to: 'users#new'
  get    'login', to: 'sessions#new'
  post   'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get    'admin', to: 'admin_panel#index'
  get    'manage', to: 'bids#index'
  get    'email_bidders', to: 'admin_panel#email_bidders'
  post   'send_email', to: 'admin_panel#send_email'


  resources :users 
  # Hierarchically, there are many bids to an item, many items to an auction, and 
  # of course many auctions in the system. This resource structure organizes the pages
  # this way.
  resources :auctions do
    resources :items, only: [:index, :new, :create]
  end
  resources :items, only: [:show, :edit, :update, :destroy] do
    resources :bids, only: [:new, :create]
  end
  resources :bids, only: [:index, :destroy]

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
