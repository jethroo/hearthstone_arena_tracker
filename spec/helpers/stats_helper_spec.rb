require 'rails_helper'

describe StatsHelper, type: :helper do
  let(:user) { double("user", id: 1) }

  before do
    allow(helper).to receive(:current_user).and_return(user)
  end

  describe "#win_loss_data" do
    it "should generate hero stats data" do
      expect(helper.win_loss_data).to be_an(Array)
    end
  end

  describe "#win_loss_over_time_data" do
    it "should array with win and loss data" do
      expect(helper.win_loss_over_time_data.size).to eq(2)
    end
  end
end
