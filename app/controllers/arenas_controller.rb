class ArenasController < ApplicationController
  def new
    render locals: { arena: Arena.new }
  end

  def create
    arena = Arena.create(new_arena_params.merge(user_id: current_user.id))
    if arena.persisted?
      flash[:success] = "Successfully created new Arena"
      render :show, locals: { arena: arena}
    else
      flash[:alert] = "Something went wrong, please correct the errors first!"
      render :new, locals: { arena: arena }
    end
  end

  def show
    arena = current_user.arenas.where(id: params[:id]).first
    if arena
      render locals: { arena: arena }
    else
      redirect_to :root, alert: "Arena not found"
    end
  end

  def update

  end

  def index
    render locals: { arenas: Hash[(1...current_user.arenas.size+1).zip current_user.arenas] }
  end

  private

  def new_arena_params
    params.require(:arena).permit(:hero)
  end
end
