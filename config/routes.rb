Rails.application.routes.draw do
  root 'top#index'

  resources :races do
    collection do
      get 'search'
    end
  end

  resources :horses

  resources :stalions

  resources :settings

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
  }

  namespace :api, { format: 'json' } do
    namespace :v1 do
    end
  end
end
