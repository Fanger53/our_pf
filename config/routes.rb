Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Rutas de autenticación
  resources :users, only: [:new, :create, :show, :edit, :update] do
    resources :portfolios, except: [:show]
  end
  get '/signup', to: 'users#new'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  # Rutas para portfolios
  resources :portfolios, only: [] do
    resources :portfolio_sections, path: 'sections'
  end
  
  # Página de inicio
  root "users#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  
  # Ruta dinámica para portfolios públicos (debe ir al final)
  # Esto permite URLs como /david_r, /juan_carlos, etc.
  get '/:slug', to: 'public_portfolios#show', as: :public_portfolio, constraints: { slug: /[a-z0-9_-]+/ }
end
