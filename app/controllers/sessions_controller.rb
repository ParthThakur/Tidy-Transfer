class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def new
    if user_signed_in?
      redirect_to user_url(current_user)
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      redirect_to user_url(user)
    else
      redirect_to login_url, notice: "Invalid Email or Password."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "Logged out"
  end
end
