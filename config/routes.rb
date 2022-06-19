Rails.application.routes.draw do
  root 'top#index'

  resources :races do
    collection do
      get 'search'
    end
  end

  resources :horses

  resources :stalions

  resources :courses

  get "/courses/1/events/2" => "courses#event"

  resources :settings

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
  }

  namespace :api, { format: 'json' } do
    namespace :v1 do
      get 'scraping/race_date_info/:race_date' => 'scraping#fetch_race_date_info'
      get 'scraping/race_info/:race_id' => 'scraping#fetch_race_info'
    end
  end
end
