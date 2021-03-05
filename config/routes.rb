Rails.application.routes.draw do
  get 'leagues/show'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #Routes for user
  resources :users, only: [:show, :edit, :update]

  #Routes for the team
  resources :teams, only: [:show, :new, :create, :edit, :update] do
    resources :leagues, only: [:index]
    member do
      get 'finalize', as: :finalize
      patch 'switch', as: :switch
    end
  end

  #Routes for footballers
  resources :footballers, only: [:index, :show]

  #Routes for fixtures
  resources :fixtures, only: [:index, :show]

  #Routes for leagues
  resources :leagues, only: [:show]

  # Routes for sidekiq
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
