class MatchesController < ApplicationController
  def index
    matches = params[:arena_id] ? current_user.arenas.where(id: params[:arena_id]).first : current_user.matches
    render locals: { matches: matches }
  end

  def new
  end

  def create
    match_params
    match = Match.create(
              user_id: current_user.id,
              hero: params[:match][:hero],
              opponent: "opponent_#{params[:match][:opponent]}",
              won: params[:match][:win]
            )
    render layout: false, locals: { match: match.decorate }
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
    match = current_user.matches.where(id: params[:id]).first
    if match
      match.destroy
      head :ok, content_type: "text/html"
    else
      head :not_found, content_type: "text/html"
    end
  end

  private

  def match_params
    params.require(:match).permit(:hero, :win, :opponent)
  end
end
