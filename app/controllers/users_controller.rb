class UsersController < ApplicationController
	before_action :authenticate_user!

  def show
  	@user = User.find(params[:user_id])
  	@reviews = @user.reviews
  	@blogs = @user.blogs
    @favorite_reviews = @user.favorites.where(blog_id: [nil, ''])
  	@favorite_blogs = @user.favorites.where(review_id: [nil, ''])
  	@following = @user.following_user
  	@follower = @user.follower_user
    @notifications = current_user.passive_notifications
  end

  def edit
  end
end
