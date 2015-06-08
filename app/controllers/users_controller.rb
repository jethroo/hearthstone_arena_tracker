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

  def show
    max_hero_matches = fetch_max_hero_matches

    render locals: {
      user: current_user,
      max_matches: max_hero_matches[1],
      max_hero: Match.heros.select do |_, value|
        value == max_hero_matches[0]
      end.keys.first
    }
  end

  private

  def fetch_max_hero_matches
    Match.where(user_id: current_user.id).select(:hero).group(:hero)
      .count.max_by { |_, value| value }
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
