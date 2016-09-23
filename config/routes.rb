Rails.application.routes.draw do

  #get 'administration/index'

  # get 'product/create'

  root to: 'pages#index', as: :root
  resources :users, only: [:new, :create, :show]
  resources :products, only: [:index, :new, :create, :update, :show]
  resources :accounts, only: [:index, :new, :create, :update, :show, :destroy]
  resources :accounting_periods, only: [:index, :new, :create, :update, :show, :destroy]
  resources :transaction_types, only: [:index, :new, :create, :update, :show, :destroy]
  resources :gl_mappings, only: [:index, :new, :create, :update, :show, :destroy]
  resources :vehicle_makes, only: [:index, :new, :create, :update, :show, :destroy]
  resources :vehicle_models, only: [:index, :new, :create, :update, :show, :destroy]

  resources :product_discounts, only: [:index, :new, :create, :update, :show, :destroy]
  resources :product_pricings, only: [:index, :new, :create, :update, :show, :destroy]

  resources :sequences, only: [:index, :new, :create, :update, :show, :destroy]
  resources :general_ledgers, only: [:index, :new, :create, :update, :show, :destroy]
  resources :inventories, only: [:index, :new, :create, :update, :show, :destroy]
  resources :user_sessions, only: [:create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in
  get '/email_sent', to: 'email_sent#index', as: :email_sent
  get '/activate/:activation_code', to: 'activations#create', as: :activate
  get '/admin', to: 'administration#index', as: :admin
  get '/admin/listusers', to: 'administration#listusers', as: :listusers
  post '/admin/toggleactive', to: 'administration#toggleactive', as: :toggleactive
  post '/admin/toggleapprove', to: 'administration#toggleapprove', as: :toggleapprove
  post '/admin/toggleconfirm', to: 'administration#toggleconfirm', as: :toggleconfirm
  get '/gallery', to: 'gallery#index', as: :gallery
  get '/search/:object', to: 'search#search', as: :genericsearch
  get '/sparesandaccessories', to: 'sparesandaccessories#index', as: :sparesandaccessories
  get '/accountingpanel', to: 'accountingpanel#index', as: :accountingpanel
  get '/products/customer_view', to: 'products#customer_view', as: :customer_view

  #get '/admin/deactivateuser', to: 'administration#deactivateuser', as: :deactivateuser
  #get '/new_product', to: 'products#new', as: :new_product
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
