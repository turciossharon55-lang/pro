Rails.application.routes.draw do
  get "posts/new"
  get "posts/index"
  get "posts/show"
  root "posts#index"
  resources :posts
  devise_for :users
end
