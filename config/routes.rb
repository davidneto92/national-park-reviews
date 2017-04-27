Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'parks#index'

  # get 'secret' => 'pages#secret'

  resources :users

  resources :parks do
    resources :reviews
  end

  resources :parks do
    post 'upvote'
    post 'downvote'
  end

  resources :reviews do
    post 'upvote'
    post 'downvote'
  end

  # resources :parks do
  #   resources :reviews do
  #     post 'upvote'
  #     post 'downvote'
  #   end
  # end
  
end
