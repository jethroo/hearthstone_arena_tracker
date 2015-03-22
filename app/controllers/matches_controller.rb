class MatchesController < ApplicationController
  def index
    matches = params[:arena_id] ? matches_by_arena_id( params[:arena_id]) : numbered_hash(current_user.matches)
    render locals: { matches: matches }
  end

  def new
  end

  def create
    if params.require(:opponent) && params.require(:win) && params.require(:hero)
      match = Match.create(
                user_id: current_user.id,
                hero: params[:hero],
                opponent: "opponent_#{params[:opponent]}",
                won: params[:win]
              )
      render layout: false, locals: { match: match.decorate }
    end
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def match_params
    params.require(:match).permit(:hero, :win, :opponent)
  end

  def matches_by_arena_id(id)
    arena = current_user.arenas.where(id: params[:arena_id]).first
    arena ? numbered_hash(arena.matches) : {}
  end

  def numbered_hash(collection)
    Hash[(1...collection.size+1).zip collection]
  end
end
