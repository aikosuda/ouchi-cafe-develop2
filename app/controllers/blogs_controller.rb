class BlogsController < ApplicationController
  def show
    @blog = Blog.find(params[:id])
    @tag_list = @blog.tags
  end

  def index
    @tag_list = Tag.all
    @blogs = Blog.page(params[:page]).per(10)
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
  end

  def tag
    @tag_list = Tag.all
    @tag = Tag.find_by(name: params[:name])
    @blogs = @tag.blogs.page(params[:page]).per(10)
    render :index
  end

  def search
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content, :image)
  end

end
