Rails.application.routes.draw do
  root                'static_pages#home'
  get    'signup'  => 'users#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :arenas
  resources :matches

  get "stats"      => "stats#overview"
  get "stats/win_loss"      => "stats#win_loss", defaults: { format: :json }
end
