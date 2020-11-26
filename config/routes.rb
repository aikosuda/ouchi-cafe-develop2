Rails.application.routes.draw do
  # メインページルーティング
  root 'home#top'
  get 'home/about' => 'home#about'
  post 'home/guest_sign_in' => 'home#new_guest'

  post 'blogs/:blog_id/favorites' => 'favorites#like_blog', as: 'blog_like'
  delete 'blogs/:blog_id/favorites' => 'favorites#unlike_blog', as: 'blog_unlike'

  post 'reviews/:review_id/favorites' => 'favorites#like_review', as: 'review_like'
  delete 'reviews/:review_id/favorites' => 'favorites#unlike_review', as: 'review_unlike'

  devise_for :users
  resources :users, only: [:edit, :update] do
    # マイページ表示
    get 'my_page' => 'users#show'
    # フォローする・外す
    resource :relationships, only: [:create, :destroy]
  end

  resources :reviews do
    collection do
      # カテゴリー検索用
      post 'category'
      # レビュー検索ページ
      get 'select'
      # レビュー検索結果ページ
      get 'search'
    end
  end

  resources :blogs do
    collection do
      # タグ検索用
      post 'tag'
      # ブログ検索ページ
      get 'select'
      # ブログ検索結果ページ
      get 'search'
    end

    resources :blog_comments, only: [:create, :destroy]
  end

  resources :notifications, only: [:index, :destroy]

  resources :review_categories, only: [:create, :destroy]

  resources :contacts, only: [:new, :create]

end
