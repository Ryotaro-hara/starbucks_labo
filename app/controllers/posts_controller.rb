class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_target_post, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  MAX_LIKED_POSTS_COUNT = 5

  def index
    @posts = Post.page(params[:page])
    @all_ranks = Post.find(Favorite.group(:post_id).order("count(post_id) desc").limit(MAX_LIKED_POSTS_COUNT).pluck(:post_id))
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

  def show
    @comments = @post.comments
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: "投稿を更新しました"
    else
      flash.now[:alert] = "投稿の編集に失敗しました"
      render "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: "投稿を削除しました"  
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :drink_type, :extra_fee, :change, :image).merge(user_id: current_user.id)
  end

  def set_target_post
    @post = Post.find(params[:id])
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      redirect_to root_path, alert: "他のユーザーの投稿は編集できません"
    end
  end
end
