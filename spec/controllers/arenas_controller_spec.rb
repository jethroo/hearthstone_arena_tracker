require "rails_helper"

RSpec.configure {|c| c.include SessionsHelper }

describe ArenasController, type: :controller do
  let(:user) { double("user", id: 1) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "new" do
    before do
      allow(controller).to receive(:render)
    end

    after do
      expect(controller)
        .to have_received(:render)
          .with(locals: { arena: instance_of(Arena) })
    end

    it "will render new arena new" do
      get :new
    end
  end

  describe "create" do
    let(:params) do
      { hero: Hero::HEROS.first }
    end

    context "arena persisted succesfully" do
      before do
        allow(controller).to receive(:render)
      end

      after do
        expect(controller)
          .to have_received(:render)
            .with(:show, locals: { arena: instance_of(Arena) })
      end

      it "will render arena show" do
        expect{ post :create, arena: params }
          .to change{ flash[:success] }
            .from(nil)
            .to(/Successfully created new Arena/)
      end
    end

    context "arena not persisted" do
      before do
        allow(controller).to receive(:render)
        allow_any_instance_of(Arena).to receive(:persisted?).and_return(false)
      end

      after do
        expect(controller)
          .to have_received(:render)
            .with(:new, locals: { arena: instance_of(Arena) })
      end

      it "will render arena new" do
        expect{ post :create, arena: params }
          .to change{ flash[:alert] }
            .from(nil)
            .to(/Something went wrong/)
      end
    end
  end

  describe "show" do
    context "if arena found" do

    end

    context "if arena not found" do

    end
  end
end

=begin

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

=end
