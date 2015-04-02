require "rails_helper"

describe MatchesController, type: :controller do
  let(:user) { double("user", id: 1) }
  let(:matches) do
      double("matches")
  end

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "index" do
    before do
      allow(controller).to receive(:render)
      allow(user).to receive(:matches).and_return(matches)
      allow(matches).to receive(:includes).with(:arena).and_return(matches)
      allow(matches)
        .to receive(:order).with(created_at: :desc).and_return(matches)
    end

    after do
      expect(controller)
        .to have_received(:render).with(locals: { matches: matches })
      expect(matches)
        .to have_received(:includes).with(:arena)
      expect(matches)
        .to have_received(:order).with(created_at: :desc)
    end

    it "renders index" do
      expect(get :index).to be_ok
    end
  end

  describe "#new" do
    before do
      allow(controller).to receive(:render)
      allow(user).to receive(:matches).and_return(matches)
      allow(matches)
        .to receive(:order).with(created_at: :desc).and_return(matches)
      allow(matches)
        .to receive(:limit).with(12).and_return(matches)
    end

    after do
      expect(controller)
        .to have_received(:render).with(locals: { matches: matches })
      expect(matches)
        .to have_received(:order).with(created_at: :desc)
      expect(matches)
        .to have_received(:limit).with(12)
    end

    it "renders new" do
      expect(get :new).to be_ok
    end
  end

  describe "#create" do
    let(:valid_params) do
      {
        match: {
                  hero: Hero::HEROS.first,
                  win: true,
                  opponent: Hero::HEROS.last,
                  arena: 1
               }
      }
    end

    let(:arenas) { double("arenas") }
    let(:arena) { Arena.new }

    before do
      allow(user).to receive(:arenas).and_return(arenas)
      allow(arenas).to receive(:where).and_return([arena])
    end

    context "match created" do
      before do
        allow(arena).to receive(:valid?).and_return(true)
      end

      it "renders create template without layout" do
        expect(post :create, valid_params).to render_template(:create)
      end
    end

    context "match invalid" do
      before do
        allow(arena).to receive(:valid?).and_return(false)
      end

      it "renders error template without layout" do
        expect(post :create, valid_params)
          .to render_template("matches/ajax_error")
      end
    end
  end

  describe "#destroy" do
    let(:matches) { double("matches") }
    let(:match) { double("match") }

    before do
      allow(user).to receive(:matches).and_return(matches)
    end

    context "not_found" do
      before do
        allow(matches).to receive(:where).and_return([])
      end

      it "will respond with not_found" do
        expect(delete :destroy, id: 1).to be_not_found
      end
    end

    context "destroy" do
      before do
        allow(matches).to receive(:where).and_return([match])
        allow(match).to receive(:destroy)
      end

      after do
        expect(match).to have_received(:destroy)
      end

      it "will respond with ok " do
        expect(delete :destroy, id: 1).to be_ok
      end
    end
  end
end
