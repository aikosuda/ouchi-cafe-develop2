class BlogCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: [:create, :destroy]

  def new
    @blog_comment = BlogComment.new
  end

  def create
    @blog_comments = @blog.blog_comments
    @blog_comment = current_user.blog_comments.new(blog_comment_params)
    @blog_comment.blog_id = @blog.id
    respond_to do |format|
      if @blog_comment.save
        format.html
        format.js
        @blog.create_notification_comment!(current_user, @blog_comment.id)
      else
        format.html
        format.js { render 'new' }
       end
    end
  end

  def destroy
    @blog_comment = BlogComment.find_by(id: params[:id], blog_id: params[:blog_id])
    @blog_comment.destroy
  end

  private

    def blog_comment_params
      params.require(:blog_comment).permit(:comment)
    end

    def set_blog
      @blog = Blog.find(params[:blog_id])
    end
end
