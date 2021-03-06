class StatsController < ApplicationController
  include StatsHelper

  def overview; end

  def win_loss
    respond_to do |format|
      format.json { render json: win_loss_data }
    end
  end

  def win_loss_over_time
    respond_to do |format|
      format.json { render json: win_loss_over_time_data }
    end
  end

  def arena_win_loss_by_class
    respond_to do |format|
      format.json { render json: arena_win_loss_by_class_data }
    end
  end
end
