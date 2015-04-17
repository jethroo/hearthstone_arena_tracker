class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def create
    user = User.find_by(name: params[:session][:name])
    if authentication_successful?(user)
      log_in user
      flash[:success] = "Welcome back #{user.name}!"
    else
      flash[:alert] = 'The credentials you provided seem to be incorrect!'
    end

    redirect_to :root
  end

  def destroy
    flash[:success] = %(You have been logged out.
                          See you soon #{current_user.name}!
                       )
    log_out
    redirect_to :root
  end

  private

  def authentication_successful?(user)
    return unless user
    user.authenticate(params[:session][:password])
  end
end
