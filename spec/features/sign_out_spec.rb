require 'rails_helper'

describe "the signout process", :type => :feature do
  it "signs me out", :js => true do
    sign_out
  end
end
