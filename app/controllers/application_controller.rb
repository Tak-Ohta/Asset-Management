class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  # paramsハッシュからユーザー（:id）を取得する
  def set_user
    @user = User.find(params[:id])
  end

  # paramsハッシュからユーザー（:user_id）を取得する
  def set_user_id
    @user = User.find(params[:user_id])
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

    # アクセスしたユーザーが現在ログインしているユーザー（:user_id）か確認する
    def correct_user_id
      @user = User.find(params[:user_id])
      redirect_to login_url unless current_user?(@user)
    end

  # システム管理権限者かどうか判定する
  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
