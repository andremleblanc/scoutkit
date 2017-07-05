Rails.application.routes.draw do
  resource :settings, only: [:show]
  resources :trackers, only: [:index, :new, :create]
  resources :hashtag_trackers, only: [:show, :destroy]

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root 'dashboard#show', as: :dashboard
end
