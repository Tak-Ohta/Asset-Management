class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
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

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                    :birthday, :sex, :prefecture, :occupation, :marriage,
                                    :annual_income)
    end
end
