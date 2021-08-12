class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user # ユーザー登録成功後、ログインする
      flash[:success] = "新規登録に成功しました。"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      flash.now[:danger] = "更新に失敗しました。やり直してください。"
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                    :birthday, :sex, :prefecture, :occupation, :marriage,
                                    :annual_income)
    end

    # paramsハッシュからユーザーを取得する
    def set_user
      @user = User.find(params[:id])
    end

    # ログイン済みのユーザーか確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end

    # アクセスしたユーザーが現在ログインしているユーザーか確認する
    def correct_user
      @user = User.find(params[:id])
      redirect_to login_url unless current_user?(@user)
    end

    # システム管理権限者かどうか判定する
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
