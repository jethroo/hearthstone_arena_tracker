class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    render locals: { user: User.new }
  end

  def create
    user = User.create(user_params)
    if user.persisted?
      flash[:success] = "Welcome on board #{user_params[:name]}"
      log_in user
      redirect_to :root
    else
      flash[:alert] = 'Whoops'
      render :new, locals: { user: user }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
