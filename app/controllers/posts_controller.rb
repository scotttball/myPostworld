class PostsController < ApplicationController
  def index
    @posts = Post.all.order updated_at: :desc
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new(user_id: params[:user_id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to user_path(@post.user)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update 
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to user_path(@post.user)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      redirect_to user_path(post.user)
    else
      redirect_to posts_path(post)
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :body)
  end
end
