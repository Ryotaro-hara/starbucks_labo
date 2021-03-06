class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @post = @user.posts.includes(:user).order("created_at desc")
    @posts = Post.includes(:user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user), flash: { notice: "ユーザー情報を編集しました。" }
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image)
  end
end
