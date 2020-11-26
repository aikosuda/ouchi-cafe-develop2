class BlogsController < ApplicationController
  def show
    @blog = Blog.find(params[:id])
    @tag_list = @blog.tags
    @blog_comment = BlogComment.new
    @blog_comments = @blog.blog_comments.reverse_order
  end

  def index
    @tag_list = Tag.page(params[:page]).per(6)
    @tag_lists = Tag.all
    @blogs = Blog.page(params[:page]).per(5)
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.new(blog_params)
    tag_list = params[:blog][:name].split(/[[:blank:]]/)
    if @blog.save
      @blog.save_tag(tag_list)
      redirect_to blog_path(@blog), notice: "記事を作成しました"
    else
      render :new
    end
  end

  def edit
    @blog = Blog.find(params[:id])
    @tag_list = @blog.tags.pluck(:name).join
  end

  def update
    @blog = Blog.find(params[:id])
    tag_list = params[:blog][:name].split(/[[:blank:]]/)
    if @blog.update(blog_params)
      @blog.save_tag(tag_list)
      redirect_to blog_path(@blog), notice: "記事を更新しました"
    else
      render :new
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    if @blog.destroy
      redirect_to blogs_path, notice: "記事を削除しました"
    else
      render :show
    end
  end

  def select
    @tag_list = Tag.page(params[:page]).per(6)
    @tag_lists = Tag.all
    @blogs = Blog.page(params[:page]).per(4)
  end

  def tag
    @tag_list = Tag.page(params[:page]).per(6)
    @tag_lists = Tag.all
    @tag = Tag.find_by(name: params[:name])
    @blogs = @tag.blogs.page(params[:page]).per(10)
    render :index
  end

  def search
    @tag_list = Tag.page(params[:page]).per(6)
    @tag_lists = Tag.all
    @search = params[:search]
    @user_or_title = params[:option]
    if @user_or_title == "1"
      @users = User.search_blog(params[:search])
      @users.each do |user|
        @user_blogs = Blog.where(user_id: user.id).page(params[:page]).per(5)
      end
    else
      @blogs = Blog.search_blog(params[:search]).page(params[:page]).per(5)
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content)
  end
end
