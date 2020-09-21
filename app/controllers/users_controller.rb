class UsersController < ApplicationController
	before_action :authenticate_user!

  def show
  	@user = User.find(params[:user_id])
  	@reviews = @user.reviews
  	@blogs = @user.blogs
  	@favorite_blogs = @user.favorites
  	@following = @user.following_user
  	@follower = @user.follower_user
  end

  def edit
  end
end
