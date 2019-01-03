Rails.application.routes.draw do
  resources :reviews
  devise_for :users,
              path: '',
              path_names: { sign_in: 'login', sign_up: 'registration', sign_out: 'logout', edit: 'profile' }
  resources :movies do
    resources :reviews, except: [:show, :index]
  end
  root 'movies#index'
end
