StoryUp::Application.routes.draw do

  resources :comments

  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions"}

  devise_scope :user do
    get 'users/if_user_exist', to: "users/registrations#if_user_exist?"
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  resources :stories do
      collection do
        post  ':id/rate' => "stories#rate"
      end 
      resources :nodes do
        collection do
          post ':id/rate' => "nodes#rate"
          get  ':id/new_follow' => "nodes#new_follow"
          post ':id/follow_up'  => "nodes#follow_up"
          get  ':id/subordinates'  => "nodes#subordinates"
          get  '/nodeFirstByStryId'  => "nodes#nodeFirstByStryId"
          get  ':id/rateCount'  => "nodes#rateCount"
        end
      end
  end
  
  resources :comments do
    collection do
      get ':nodeId/commentCount' => "comments#commentCount"
      get ':nodeId/nodeComments' => "comments#list"
    end   
	end 
	
	resources :qqopen do
    collection do
     
      get '/word_filter' => "qqopen#word_filter"
    end   
	end 
	
  resources :users do
    collection do
      get ':id/stories' => "users#stories"
      get ':id/readings' => "users#readings"
    end
  end
  resources :statistics
  resources :user_actions
	resources :user_actions do
    collection do
      delete ':nodeId/:userId' => "user_actions#deleteBynodeIdUserId"
       
    end
  end
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
