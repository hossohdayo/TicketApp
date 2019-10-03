class UserController < ApplicationController
  skip_before_action :check_logined, only: [:new, :create]
  before_action :ensure_correct_user, only: [:edit]

  def new
    @user = User.new
  end

  def index
    @user = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:msg] = "ユーザーを編集しました"
      redirect_to '/user/index'
    else
      render 'user/edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:usr] = @user.id
      flash[:msg] = "ユーザーを登録しました"
      redirect_to '/user/index'
    else
      render 'user/new'
    end
  end

  def destroy
    obj = User.find_by(id: params[:id])
    obj.destroy
    flash[:msg] = "ユーザーを削除しました"
    redirect_to '/user/index'
  end

  def ensure_correct_user
    @user = User.find_by(id: params[:id])
    if @user.id != @usr.id
      redirect_to '/user/index'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :comment, :password)
  end
end
