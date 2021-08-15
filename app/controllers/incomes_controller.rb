class IncomesController < ApplicationController
  before_action :set_user_id, only: [:index, :new, :create, :edit, :update, :destroy]
  
  def index
    @incomes = @user.incomes
  end
  
  def new
    @income = Income.new
  end

  def create

  end
  
  def edit

  end

  def update

  end

  def destroy

  end


end
