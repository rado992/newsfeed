class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @messages = Message.asc(:created_at).limit(20)
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
    @user.encrypt
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to NewsfeeD!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :password)
    end
end
