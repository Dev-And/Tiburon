class UsersController < ApplicationController
  before_action :sign_in_user, only: [:edit, :update, :show]
  before_action :correct_user, :admin_user, only: [:edit, :update, :show]
  before_action :admin_user, only: [:destroy]

   def show
    @user = current_user
  end

  def new
    @user = User.new
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  def create
    @user = User.new(user_params)
    if @user.save #After mailing, make a line 'signin' after user.save
      @user.send_activation_email
      flash[:info] = "Пожалуйста проверьте ваш email чтобы активировать аккаунт."
      redirect_to root_url
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  def sign_in_user
    unless signed_in?
      store_location
      flash[:warning] = "Пожалуйста авторизируйтесь."
      redirect_to signin_url
    end
  end
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
