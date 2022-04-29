class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path, notice: "新規投稿に成功しました"
    else
      flash.now[:alert] = "新規投稿に失敗しました"
      render "new"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :extra_fee, :change, :image).merge(user_id: current_user.id)
  end
end
