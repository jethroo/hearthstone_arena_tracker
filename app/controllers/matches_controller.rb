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

  # TODO: do js the rails way!
  #https://pragmaticstudio.com/blog/2015/3/18/rails-jquery-ajax?utm_source=rubyweekly&utm_medium=email
  def create
     match = Match.create(
                user_id: current_user.id,
                opponent: params[:hero],
                won: params[:win]
              )

    respond_to do |format|
      format.html { render locals: match }
      format.js { render locals: match }
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
