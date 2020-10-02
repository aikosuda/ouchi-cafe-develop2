class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: [:like_blog, :unlike_blog]
  before_action :set_review, only: [:like_review, :unlike_review]

  def like_blog
    @favorite = current_user.favorites.new(blog_id: @blog.id)
    @favorite.save
    @blog.create_notification_favorite_blog!(current_user)
  end

  def unlike_blog
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
    @favorite.destroy
  end

  def like_review
    @favorite = current_user.favorites.new(review_id: @review.id)
    @favorite.save
    @review.create_notification_favorite_review!(current_user)
  end

  def unlike_review
    @favorite = current_user.favorites.find_by(review_id: @review.id)
    @favorite.destroy
  end

  private

    def set_blog
      @blog = Blog.find(params[:blog_id])
    end

    def set_review
      @review = Review.find(params[:review_id])
    end
end
