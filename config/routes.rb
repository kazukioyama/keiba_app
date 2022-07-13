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
      get 'scraping/daily_race_data/:race_date' => 'scraping#fetch_daily_race_data'
      get 'scraping/daily_race_data_for_fullcalendar/:race_date' => 'scraping#fetch_daily_race_data_for_fullcalendar'
      get 'scraping/race_info/:race_id' => 'scraping#fetch_race_info'
    end
  end
end
