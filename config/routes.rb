Rails.application.routes.draw do
  root 'static_pages#index'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  constraints subdomain: 'api' do
    namespace :api, path: '/' do
      resources :games, only: [:index, :new, :create, :show] do
        resources :players, only: [:new, :create, :index]
      end
    end
  end
end
