class HomeController < ApplicationController
  def top
    @reviews = Review.page(params[:page]).per(9)
    @blog_ranks = Blog.find(Favorite.group(:blog_id).order('count(blog_id) desc').limit(3).pluck(:blog_id))
  end

  def about
  end

  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com', name: 'guest_user', introduction: 'はじめまして！！') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
