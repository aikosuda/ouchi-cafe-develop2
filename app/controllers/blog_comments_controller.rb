class BlogCommentsController < ApplicationController
  def create
  	@blog = Blog.find(params[:blog_id])
  	@comment = current_user.blog_comments.new(blog_comment_params)
  	@comment.blog_id = @blog.id
  	if @comment.save
  		redirect_to request.referer, notice: "コメントを送信しました"
  	else
    @tag_list = @blog.tags
    @blog_comments = BlogComment.where(blog_id: @blog.id)
  	render 'blogs/show'
  	end
  end

  def destroy
  	@blog_comment = BlogComment.find_by(id: params[:id], blog_id: params[:blog_id])
  	if @blog_comment.destroy
  		redirect_to request.referer, notice: "コメントを削除しました"
  	else
  		@tag_list = @blog.tags
    	@blog_comments = BlogComment.where(blog_id: @blog.id)
  		render 'blogs/show'
  	end
  end

  private
  def blog_comment_params
  	params.require(:blog_comment).permit(:comment)
  end
end
