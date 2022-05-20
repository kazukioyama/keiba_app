Rails.application.routes.draw do
  root 'top#index'

  resources :races do
    collection do
      get 'search'
    end
  end

  resources :settings

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
  }
end
