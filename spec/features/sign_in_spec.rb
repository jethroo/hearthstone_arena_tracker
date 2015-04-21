require 'rails_helper'

describe 'the signin process', type: :feature do
  it 'signs me in', js: true do
    signed_in_user
  end
end
