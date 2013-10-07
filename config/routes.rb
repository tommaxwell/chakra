BrainDb::Application.routes.draw do

  devise_for :users

  resources :submissions
    get "/submissions/new(.:format)" => "submissions#new"
    get "/submissions/:id(.:format)" => "submissions#show"
    post "/submissions/:id(.:format)" => "submissions#update"
    get "/submissions/:id/delete(.:format)" => "submissions#destroy"
    get "/parent_submissions(.:format)" => "submissions#parent"
    get "/new_submission(.:format)" => "submissions#new_submission"
    get "/highlight_node(.:format)" => "submissions#highlight_node"

  resources :folders
    get "/ajax_load_events(.:format)" => "folders#ajax_load_events"
  
  root to: 'home#index'

  scope "api" do
    get "/submissions(.:format)" => "submissions#index"
    get "/submissions/:id(.:format)" => "submissions#show"
    get "/:user_id/submissions(.:format)" => "submissions#usercontent"
    get "/:user_id/submissions/:id(.:format)" => "submissions#usersubmission"

  end

  get "/:user_id/folders(.:format)" => "folders#userfolders"

  get "/submissions/:id/edit(.:format)" => "submissions#edit"

  get "/folders/new(.:format)" => "folders#new"

  get "/folders/show/:id(.:format)" => "folders#show"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
