Timeboard::Application.routes.draw do

  get "sessions/new"

  resources :courses
  resources :users
  resources :professors
  resources :students 
  resources :finances

  resources :holidays

  resources :timesheets do
    member do
      put :sign, :approve, :process
      #or is this supposed to be POST? Will check when I have internet again
    end
  end
  
  match '/professor/list',	:to => 'professors#timesheet_list'
  match '/login',		:to => 'pages#login'
  match '/logout',		:to => 'pages#logout'
  match '/admin/index',		:to => 'admin#index'
  match '/admin',		:to => 'admin#index'
  match '/admin/addStudent',	:to => 'admin#addStudent'
  match '/admin/removeStudent', :to => 'admin#removeStudent'
  match '/admin/editStudent',	:to => 'admin#editStudent'
  match '/admin/addCourse',	:to => 'admin#addCourse'
  match '/admin/removeCourse',	:to => 'admin#removeCourse'
  match '/admin/editCourse',	:to => 'admin#editCourse'
  match '/holidays/create',     :to => 'holidays#create'
  root :to => 'pages#home'

  get "pages/home"
  get "pages/login"
  get "pages/logout"
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
  # match ':controller(/:action(/:id(.:format)))'
end
