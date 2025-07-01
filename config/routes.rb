Rails.application.routes.draw do
  resources :posts do
    resources :likes, only: [ :index, :create, :destroy ]
    resources :comments, only: [ :create, :destroy ]
  end
  resources :follow_requests, only: [ :index, :create, :update, :destroy ]

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  resources :users, only: [ :index, :show, :edit, :update ] do
    get "followers", to: "users#followers_index", as: :followers
    get "following", to: "users#following_index", as: :following
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "posts#index"
end
