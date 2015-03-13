class SessionsController < ApplicationController

  def create
    user = User.find_by(name: params[:session][:name])

    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "Welcome back #{user.name}!"
    else
      flash[:alert] = "The credentials you provided seem to be incorrect!"
    end

    redirect_to :root
  end

  def destroy
    flash[:success] = "You have been logged out. See you soon #{current_user.name}!"
    log_out
    redirect_to :root
  end
end
