class MatchesController < ApplicationController
  def index
    respond_to do |format|
      format.html { render }
      format.json { render layout: false, json: decorated_matches }
    end
  end

  def new
    render locals: {
      matches: current_user
        .matches
        .order(created_at: :desc)
        .limit(12)
    }
  end

  def create
    match = Match.new(match_params)

    if match.save
      render layout: false, locals: { match: match.decorate }
    else
      render template: 'matches/ajax_error', layout: false, status: :error,
             locals: { match: match.decorate }
    end
  end

  def destroy
    match = current_user.matches.where(id: params[:id]).first
    if match
      match.destroy
      head :ok, content_type: 'text/html'
    else
      head :not_found, content_type: 'text/html'
    end
  end

  private

  def decorated_matches
    current_user.matches.includes(:arena).order(created_at: :desc)
                .paginate(page: params[:page], per_page: params[:per_page]).decorate
  end

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
    if match_arena(match[:arena])
      match_hash[:arena] = match_arena(match[:arena])
    end

    match_hash
  end

  def match_arena(arena_param)
    return nil unless arena_param.present?
    current_user.arenas.where(id: arena_param).first
  end
end
