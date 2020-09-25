class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def show
    @review = Review.find(params[:id])
    @review_categories = ReviewCategory.all
  end

  def index
    @reviews = Review.page(params[:page]).per(9)
    @review_categories = ReviewCategory.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to review_path(@review), notice: "レビューを投稿しました"
    else
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to review_path(@review), notice: "レビューを更新しました"
    else
      render  :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      redirect_to reviews_path, notice: "レビューを削除しました"
    else
      render :show
    end
  end

  def select
    @review_categories = ReviewCategory.all
    @reviews = Review.page(params[:page]).per(6)
  end

  def category
    @review_category = ReviewCategory.find_by(name: params[:name])
    @reviews = Review.where(review_category_id: @review_category.id).page(params[:page]).per(10)
    @review_categories = ReviewCategory.all
    render :index
  end

  def search
    @review_categories = ReviewCategory.all
    @user_or_product = params[:option]
    @search = params[:search]
    if @user_or_product == "1"
        @users = User.search_review(params[:search])
        @users.each do |user|
          @user_reviews = Review.where(user_id: user.id).page(params[:page]).per(9)
        end
    elsif @user_or_product == "2" 
        @reviews = Review.search_review(params[:search]).page(params[:page]).per(9)
    else
        @same_reviews = Review.where(name: params[:review][:name]).page(params[:page]).per(9)
        @same_review_name = params[:review][:name]
    end
  end

  private

  def review_params
    params.require(:review).permit(:name, :content, :image, :rate, :manufacturer, :price, :review_category_id)
  end


end
