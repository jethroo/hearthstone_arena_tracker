class MatchesController < ApplicationController
  def index
    matches = params[:arena_id] ? matches_by_arena_id( params[:arena_id]) : numbered_hash(current_user.matches)
    render locals: { matches: matches }
  end

  def new
  end

  def create_remote
    if params.require(:hero) && params.require(:win)
      match = Match.create(
                user_id: current_user.id,
                opponent: params[:hero],
                won: params[:win]
              )
      render layout: false, locals: { match: match }
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

  def matches_by_arena_id(id)
    arena = current_user.arenas.where(id: params[:arena_id]).first
    arena ? numbered_hash(arena.matches) : {}
  end

  def numbered_hash(collection)
    Hash[(1...collection.size+1).zip collection]
  end
end
