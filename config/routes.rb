Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users, path_names: { sign_in: 'login', edit: 'edit/profile' }

  resources :users, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
