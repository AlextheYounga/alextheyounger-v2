class SessionsController < ApplicationController
  def login; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = 'Welcome Master'
      redirect_to root_path
    else
      flash.now[:danger] = 'There was something wrong with your log in information'
      render 'login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'The Master has logged out'
    redirect_to root_path
  end
end
