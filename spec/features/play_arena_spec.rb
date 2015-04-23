require 'rails_helper'

describe 'playing an arena process', type: :feature do
  let(:arena) { Arena.new(hero: 'rexxar') }

  before do
    arena.user = signed_in_user
    arena.save!
  end

  it 'playing an arena after sign in', js: true do
    find('#arenasMenue').hover.find('#indexArenasMenueItem').click
    find('#my_arenas')
      .find("#arena_#{arena.id}")
      .find("#play_arena_#{arena.id}").click
    find('#newMatchGrid')
    find('#loose_vs_anduin a').click
    find('#win_vs_rexxar a').click
    find('#loose_vs_jaina a').click
    find('#loose_vs_guldan a').click
    expect(page).to have_css('.match_result', count: 4)
    within('#arenaFinishedModal') do
      expect(page).to have_content('Arena finished')
      find('#claim_reward_link').click
    end
    find("#edit_arena_#{arena.id}")
  end
end
