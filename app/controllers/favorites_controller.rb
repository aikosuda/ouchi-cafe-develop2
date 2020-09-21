class FavoritesController < ApplicationController
	before_action :authenticate_user!

	def like_blog
		@blog = Blog.find(params[:blog_id])
		@favorite = current_user.favorites.new(blog_id: @blog.id)
		@favorite.save
	end

	def unlike_blog
		@blog = Blog.find(params[:blog_id])
		@favorite = current_user.favorites.find_by(blog_id: @blog.id)
		@favorite.destroy
	end

	def like_review
		@review = Review.find(params[:review_id])
		@favorite = current_user.favorites.new(review_id: @review.id)
		@favorite.save
	end

	def unlike_review
		@review = Review.find(params[:review_id])
		@favorite = current_user.favorites.find_by(review_id: @review.id)
		@favorite.destroy
	end
end
