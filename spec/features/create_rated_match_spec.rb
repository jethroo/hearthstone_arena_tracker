require 'rails_helper'

describe "create a match process", :type => :feature do
  it "create a match after sign in", :js => true do
    signed_in_user
    find('#matchesMenue').hover.find('#addMatchMenueItem').click
    find('#newMatchGrid')
    select "anduin", from: "hero"
    %w(win loose).each do |result|
      Arena::HEROS.each do |hero|
        find("##{result}_vs_#{hero} a").click
      end
    end
  end
end
