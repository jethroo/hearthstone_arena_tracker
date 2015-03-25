class MatchesController < ApplicationController
  def index
    matches = params[:arena_id] ? current_user.arenas.where(id: params[:arena_id]).first : current_user.matches.includes(:arena)
    render locals: { matches: matches.order(created_at: :desc) }
  end

  def new
    render locals: { matches: current_user.matches.order(created_at: :desc).limit(12) }
  end

  def create
    match = Match.new(match_params)
    if match.save
      render layout: false, locals: { match: match.decorate }
    else
      render template: "matches/ajax_error", layout: false, status: :error, locals: { match: match.decorate }
    end
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
    params.require(:match).permit(:hero, :win, :opponent, :arena)
    match_hash(params[:match])
  end

  def match_hash(match)
    match_hash = {
                    user_id: current_user.id,
                    hero: match[:hero],
                    opponent: "opponent_#{match[:opponent]}",
                    won: match[:win]
                 }
    if match[:arena] && match[:arena].present? && current_user.arenas.exists?(match[:arena])
      match_hash.merge!(arena_id: match[:arena])
    end

    match_hash
  end
end
