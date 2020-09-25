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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :email, :profile_image)
  end


end
