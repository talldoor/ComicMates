Rails.application.routes.draw do
  root to: 'top#home'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  resources :users, only: [:index, :show] do
    member do
      get :following
      get :followers
    end
  end
  get 'setting/password', to: 'users#edit_password'
  patch 'setting/password', to: 'users#update_password'
  get 'setting/account', to: 'users#edit_account'
  patch 'setting/account', to: 'users#update_account'
  resources :articles do
    resources :comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
end
