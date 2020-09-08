Rails.application.routes.draw do

  # メインページルーティング
  root 'home#top'
  get 'home/about' => 'home#about'

  devise_for :users
  resources :users, only: [:edit, :update] do
    #マイページ表示
  	get 'my_page' => 'users#show'

 end

  resources :reviews do
    collection do
      #カテゴリー検索用
      post 'category'
      get 'select'
      get 'search'
    end
  end
  resources :blogs
  get 'blogs/select' => 'blogs#select'
  resource :favorites, only: [:create, :destroy]
  resources :blog_comments, only: [:show, :create, :destroy]



end
