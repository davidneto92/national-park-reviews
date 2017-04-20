Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'parks#index'

  # get 'secret' => 'pages#secret'

  resources :users
  resources :parks

end
