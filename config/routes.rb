Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }


  root 'manage#index'

  # constraints subdomain: 'api' do
    scope module: 'api', as: 'api' do
      namespace :v1 do
        namespace :bank do
          resources :assets
          get 'assets/:id/content' => 'assets#content', as: 'file_download'
          resources :folders
          get 'folders/:id/items' => 'folders#items', as: 'folder_items'
        end
        get 'user/:id' => 'users#info', as: 'user_info'
        namespace :stores do
          get 'callback/:id' => 'authorization#callback', as: 'callback'
          get 'authorize/:id' => 'authorization#authorize', as: 'authorize'
        end
      end
    end
  # end

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
