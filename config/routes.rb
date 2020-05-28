# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, {
    path: 'auth',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'register'
    }
  }

  resources :contacts, except: [:show] do
    get 'autocomplete', on: :collection
  end

  get '/dashboard', to: 'dashboard#index'
end
