Rails.application.routes.draw do
  resource :access_token, only: [:new]

  resources :trackers, only: [:index, :new]
  resources :account_trackers, only: [:show, :create, :destroy]
  resources :hashtag_trackers, only: [:show, :create, :destroy]

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  authenticated do
    root to: 'trackers#index', as: :authenticated_root
  end

  root to: redirect('/welcome')
end
