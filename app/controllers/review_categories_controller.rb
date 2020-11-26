class ReviewCategoriesController < ApplicationController
  before_action :user_admin

  def create
    @review_category = ReviewCategory.new(review_category_params)
    if @review_category.save
      redirect_to request.referer, notice: "レビューのカテゴリーを追加しました"
    else
      render 'users/show'
    end
  end

  def destroy
    @review_category = ReviewCategory.find(params[:id])
    if @review_category.destroy
      redirect_to request.referer, notice: "レビューのカテゴリーを削除しました"
    else
      render 'users/show'
    end
  end

  private

  def user_admin
    if current_user.admin == false
      redirect_to root_path
    end
  end

  def review_category_params
    params.require(:review_category).permit(:name)
  end
end
