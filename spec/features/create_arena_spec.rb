require 'rails_helper'

describe 'create a arena process', type: :feature do
  it 'create an arena after sign in', js: true do
    signed_in_user
    find('#arenasMenue').hover.find('#addArenaMenueItem').click
    select 'rexxar', from: 'arena_hero'
    click_button 'Create'
    find('#newMatchGrid')
    find('#win_vs_anduin a').click
    expect(page).to have_css('.match_result', count: 1)
  end
end
