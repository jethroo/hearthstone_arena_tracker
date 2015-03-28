class StatsController < ApplicationController
  include StatsHelper

  def overview
  end

  def win_loss
    respond_to do |format|
      format.json { render json: win_loss_json }
    end
  end
end
