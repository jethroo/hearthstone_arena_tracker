class StatsController < ApplicationController
  include StatsHelper

  def overview
  end

  def win_loss
    respond_to do |format|
      format.json { render json: win_loss_json }
    end
  end

  def win_loss_over_time
    respond_to do |format|
      format.json { render json: win_loss_over_time_json }
    end
  end
end
