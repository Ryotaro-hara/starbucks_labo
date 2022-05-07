class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    if @comment.save
      redirect_to post_path(@post), notice: "コメントしました"
    else
      redirect_back fallback_location: @comment.post
      flash[:alert] = "コメントに失敗しました"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), notice: "コメントを削除しました"
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, :user_id, :post_id)
  end  
end
