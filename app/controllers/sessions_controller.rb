class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user # 引数として指定するための()を省略 log_in(user) / redirect_to(user)
      redirect_to user
    else
      flash.now[:danger] = "認証に失敗しました。やり直してください。"
      render :new
    end
  end
end
