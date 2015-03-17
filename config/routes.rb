Rails.application.routes.draw do
  root                'static_pages#home'
  get    'signup'  => 'users#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :arenas
  resources :matches
end
