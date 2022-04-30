class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.try(:authenticate, params[:password])
      sessions[:user_id] = user.id
      redirect_to user_url(@user)
    else
      redirect_to login_url, alert: "Invalid Email or Password."
    end
  end

  def destroy
    sessions[:user_id] = nil
    redirect_to index_url, notice: "Logged out"
  end
end
