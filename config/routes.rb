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
      #検索画面表示
      get 'select'
      #検索結果表示
      get 'search'
    end
  end

  resources :blogs do
    collection do
      post 'tag'
      get 'select'
      get 'search'
    end
  end

  resource :favorites, only: [:create, :destroy]
  resources :blog_comments, only: [:show, :create, :destroy]



end
