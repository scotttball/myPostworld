class CommentsController < ApplicationController
  def index
    @comment = Comment.all.order updated_at: :desc
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_path(@comment.post)
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update 
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_path(@comment.post)
    else
      render :edit
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to post_path(comment.post)
    else
      redirect_to comments_path(comment)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id, :user_id)
  end
end
