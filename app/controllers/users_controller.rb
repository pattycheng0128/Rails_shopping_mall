class UsersController < ApplicationController 

  def sign_up
    @user = User.new
  end

  def account_verify
    @user = User.new(clean_params)
    if @user.save
      redirect_to root_path
    else
      render :sign_up
    end
  end

  def sign_in
    @user = User.new
  end

  def create_session
    user = User.login(params[:user])
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "登入成功"
    else
      render :sign_in, notice: "no user"
    end
  end

  def sign_out
    session[:user_id] = nil
    redirect_to root_path, notice: "已登出"
  end

  private
  def clean_params
    params.require(:user).permit(:name, :email, :password, :is_admin)
  end

end
