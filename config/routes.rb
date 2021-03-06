Rails.application.routes.draw do

  match '/subjects',    to: 'subjects#index',    via: 'get', as: 'subjects'
  match '/teachers',    to: 'teachers#index',    via: 'get', as: 'teachers'
  get    'subjects/:id/edit'   => 'subjects#edit'

  put    'subjects/:id' => 'subjects#update'
  get    'subjects/new'   => 'subjects#new'
  post   'subjects/new'   => 'subjects#create'
  delete 'subjects/:id' => 'subjects#delete'
  get    'subjects/disciplines'  =>  'subjects#disc_loading',    as: 'disciplines'

  get    'teachers/teacher_null' => 'teachers#show'
  get    'teachers/teacher_null/:id' => 'teachers#show'
  put    'teachers/teacher_null/:id/put' => 'teachers#update'
  get    'subjects/:id'   => 'subjects#show', as: 'subject'

  delete 'teachers/:id' => 'teachers#delete'
  get    'teachers/new'   => 'teachers#new'
  post   'teachers/new'   => 'teachers#create'
  get    'teachers/:id'   => 'teachers#show_delete', as: 'teacher'
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
