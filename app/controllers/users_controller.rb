class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @messages = Message.asc(:created_at).limit(20)
  end

  def new
    @user = User.new
  end

  def index
    @user = User.all
  end

  def create
    @user = User.new(params[:user])
    @user.encrypt
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to NewsfeeD!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :password)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
