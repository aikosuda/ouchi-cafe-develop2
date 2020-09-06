Rails.application.routes.draw do

  # メインページルーティング
  root 'home#top'
  get 'home/about' => 'home#about'

  devise_for :users
  resources :users, only: [:edit, :update] do
    #マイページ表示
  	get 'my_page' => 'users#show'

 end

  resources :reviews
  get 'reviews/select' => 'reviews#select'
  resources :review_categories, only: [:show]
  resources :blogs
  get 'blogs/select' => 'blogs#select'
  resource :favorites, only: [:create, :destroy]
  resources :blog_comments, only: [:show, :create, :destroy]



end
