Rails.application.routes.draw do
  resource :settings, only: [:show]
  resources :trackers, only: [:index, :new]
  resources :account_trackers, only: [:show, :create, :destroy]
  resources :hashtag_trackers, only: [:show, :create, :destroy]

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root 'dashboard#show', as: :dashboard
end
