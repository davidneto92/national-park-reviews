Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'parks#index'

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

  namespace :api do
    namespace :v1 do
      resources :review_votes do
        post 'upvote'
        post 'downvote'
        patch 'upvote'
      end
    end
  end

end
