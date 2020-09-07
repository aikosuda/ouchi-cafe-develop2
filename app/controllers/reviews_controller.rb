class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def show
    @review = Review.find(params[:id])
    @review_categories = ReviewCategory.all
  end

  def index
    @reviews = Review.page(params[:page]).per(10)
    @review_categories = ReviewCategory.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to review_path(@review), notice: "レビューを投稿しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def select
  end

  def search
    @review_category = ReviewCategory.find_by(name: params[:name])
    @reviews = Review.where(review_category_id: @review_category.id).page(params[:page]).per(10)
    @review_categories = ReviewCategory.all
    render :index
  end

  private

  def review_params
    params.require(:review).permit(:name, :content, :image, :rate, :review_category_id)
  end


end
