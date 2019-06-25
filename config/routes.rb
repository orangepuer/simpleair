Rails.application.routes.draw do
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

  get 'your_trips', to: 'reservations#your_trips'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
