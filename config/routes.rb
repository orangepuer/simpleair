require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'pages#home'
  devise_for :users, path_names: { sign_in: 'login', edit: 'edit/profile' }

  resources :users, only: [:show]

  resources :rooms, except: [:edit] do
    member do
      get :listing
      get :pricing
      get :description
      get :photo_upload
      get :amenities
      get :location
    end
    resources :photos, only: [:create, :destroy]
    resources :reservations, only: [:create]
  end

  resources :host_reviews, only: [:create, :destroy]
  resources :guest_reviews, only: [:create, :destroy]

  resource :search

  get 'your_trips', to: 'reservations#your_trips'
  get 'your_reservations', to: 'reservations#your_reservations'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
