Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "home#index"

  resources :claims, only: [:index, :show], param: :slug
  resources :reports, only: [:new, :create]
  
  get "linter", to: "linter#index", as: :linter
  post "linter/check", to: "linter#check", as: :linter_check

  namespace :api do
    namespace :v1 do
      post "lint", to: "lint#create"
      resources :claims, only: [:index, :show] do
        collection do
          get :search
        end
      end
    end
  end
end
