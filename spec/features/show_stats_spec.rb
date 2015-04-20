require 'rails_helper'

describe "show stats process", :type => :feature do
  it "showing chats then visiting stats page", :js => true do
    signed_in_user
    find('#statsMenue').hover.find('#showStatsMenueItem').click
    expect(page).to have_css("#arena_win_loss_by_class")
    expect(page).to have_css("#win_loss_over_time")
    expect(page).to have_css("#win_loss_hero")
  end
end
