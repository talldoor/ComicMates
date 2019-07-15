Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  get 'setting/password', to: 'users#edit_password'
  patch 'setting/password', to: 'users#update_password'
  get 'setting/account', to: 'users#edit_account'
  patch 'setting/account', to: 'users#update_account'

  get 'setting/show', to: 'users#show'

  root to: 'top#index'
end
