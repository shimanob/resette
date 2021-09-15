Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :users do
    resources :likes
    member do
      get :following, :followers, :users_recipes
    end
    
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
  end
  resources :recipes do
    get :followings, on: :member
    resources :comments
    resource :likes, only: [:create, :destroy]
  end

end
