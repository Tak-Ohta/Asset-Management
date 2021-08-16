class IncomesController < ApplicationController
  before_action :set_user_id, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :correct_user_id, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_income, only: [:edit, :destroy]
  
  def index
    @incomes = @user.incomes
  end
  
  def new
    @income = @user.incomes.build
  end

  def create
    @income = @user.incomes.build
    income_params.each do |item|
      if @income.update_attributes(item)
        flash[:success] = "収入科目を登録しました。"
        redirect_to user_incomes_url(@user)
      else
        flash.now[:danger] = "登録に失敗しました。やり直してください。"
        render :new
      end
    end
  end
  
  def edit
  end

  def update
    income_params.each do |id, item|
      @income = @user.incomes.find(id)
      if @income.update_attributes(item)
        flash[:success] = "収入科目を更新しました。"
        redirect_to user_incomes_url(@user)
      else
        flash.now[:danger] = "更新に失敗しました。やり直してください。"
        render :edit
      end
    end
  end

  def destroy
    @income.destroy
    flash[:success] = "#{@income.income_name}を削除しました。"
    redirect_to user_incomes_url(current_user)
  end

  private
    def income_params
      params.require(:user).permit(incomes: :income_name)[:incomes]
    end

    def set_income
      @income = @user.incomes.find(params[:id])
    end

end
