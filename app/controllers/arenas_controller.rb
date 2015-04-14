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
    update_params
    arena = current_user.arenas.where(id: params[:id]).first
    if arena
      arena.set_rewards!(params[:arena].with_indifferent_access)
      render :show, locals: { arena: arena }
    else
      redirect_to :root, alert: "Arena not found"
    end
  end

  def index
    render locals: { arenas: current_user
                               .arenas
                               .includes(:matches)
                               .order(created_at: :desc)
                   }
  end

  private

  def new_arena_params
    params.require(:arena).permit(:hero)
  end

  def update_params
    params.require(:arena).permit(:packs, :gold, :dust, :cards, :gold_cards)
  end
end
