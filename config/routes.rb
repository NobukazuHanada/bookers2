Rails.application.routes.draw do
  get 'search' => 'search#search', as: :search
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "homes#top"
  get "home/about" => "homes#about"
  devise_for :users

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy, :show]
    get "follower" => "users#follower", as: :follower
    get "followed" => "users#followed", as: :followed
    post "search_books" => "users#search_books", as: :search_books
    resources :dms, only: [:index, :create]
  end

  resources :groups, only: [:new, :index, :show, :edit, :create, :update]
  post "groups/:id/join" => "groups#join", as: :group_join
  delete "groups/:id/join" => "groups#leave"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
