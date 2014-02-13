class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @messages = Messages.desc(:created_at).limit(20)
  end
  def new
    @user = User.new
  end
  def create
    # my_params = user_params
    # @user = User.new(user_params)
    @user = User.new(params[:user])
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
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
