Rails.application.routes.draw do
  devise_for :users
              # path: '',
              # path_names: { sign_in: 'login', sign_up: 'registration', sign_out: 'logout', edit: 'profile' }
  resources :movies
  root 'pages#home'
end
