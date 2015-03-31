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


    after do
      expect(controller)
       .to have_received(:render).with(locals: { matches: matches })
    end

    it "renders new" do
      expect(get :new).to be_ok
    end

  end
end

=begin
class MatchesController < ApplicationController
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
=end
