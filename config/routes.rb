Rails.application.routes.draw do
  root 'static_pages#index'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get 'auth/:provider/callback' => 'devise/sessions#create'
    get 'auth/failure' => redirect('/')
  end

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                   controllers: {omniauth_callbacks: "omniauth_callbacks"}
  
  constraints subdomain: 'api' do
    namespace :api, path: '/' do
      resources :games, only: [:index, :new, :create, :show] do
        resources :players, only: [:new, :create, :index]
      end
    end
  end
end
