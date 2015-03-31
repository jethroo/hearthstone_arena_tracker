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
      let(:arenas) do
        double("arenas", where: double("dataset", first: Arena.new))
      end

      before do
        allow(user).to receive(:arenas).and_return(arenas)
        allow(controller).to receive(:render)
      end

      after do
        expect(user).to have_received(:arenas)
        expect(controller)
          .to have_received(:render)
            .with(locals: { arena: instance_of(Arena) })
      end

      it "renders show" do
        get :show, { id: 1 }
      end
    end

    context "if arena not found" do
      let(:arenas) do
        double("arenas", where: [])
      end

      before do
        allow(user).to receive(:arenas).and_return(arenas)
        get :show, { id: 1 }
      end

      after do
        expect(user).to have_received(:arenas)
      end

      it "redirects to root" do
        expect(response).to be_redirect
        expect(flash[:alert]).to eq("Arena not found")
      end
    end
  end

  describe "update" do
    let(:valid_arena_params) do
      {
        packs: 1,
        gold: 100,
        dust: nil,
        cards: 2,
        gold_cards: nil
      }
    end

    context "arena found" do
      let(:arenas) do
        double("arenas", where: double("dataset", first: Arena.new))
      end

      before do
        allow(user).to receive(:arenas).and_return(arenas)
      end

      it "renders show" do
        expect(put :update, { id: 1, arena: valid_arena_params })
          .to render_template(:show)
      end
    end

    context "arena not found" do
      let(:arenas) do
        double("arenas", where: [])
      end

      before do
        allow(user).to receive(:arenas).and_return(arenas)
        put :update, { id: 1, arena: valid_arena_params }
      end

      after do
        expect(user).to have_received(:arenas)
      end

      it "redirects to root" do
        expect(response).to be_redirect
        expect(flash[:alert]).to eq("Arena not found")
      end
    end
  end

  describe "index" do
    let(:arenas) do
      double("arenas", where: double("dataset", first: Arena.new))
    end

    before do
      allow(controller).to receive(:render)
      allow(user).to receive(:arenas).and_return(arenas)
      allow(arenas).to receive(:includes).with(:matches).and_return(arenas)
    end

    after do
      expect(controller)
        .to have_received(:render)
          .with(locals: { arenas: arenas })
    end

    it "renders index" do
      expect(get :index).to be_ok
    end
  end
end
