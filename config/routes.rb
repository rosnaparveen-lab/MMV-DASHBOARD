Rails.application.routes.draw do
  root "dashboard#index"
  get "/profile", to: "profiles#show", as: :profile

  get '/master_vehicle_database', to: 'master_vehicle_database#index'

  resources :vehicle_carrier_mapping, controller: 'vehicle_carrier_mapping' do
    collection do
      get :mapper
      get :vehicles
      get :export
    end
  end

  resources :rto_carrier_mappings, only: [:index] do
    collection do
      get :export
    end
  end

  resources :rto_locations, only: [:index] do
    collection do
      get :export
    end
  end

  # Admin + Devise routes
  namespace :admin do
    resources :users
    resources :download_logs
    resources :user_activities
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
end
