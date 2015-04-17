require 'rails_helper'

describe "the signin process", :type => :feature do
  before(:all) do
    User.create(name: 'user@example.com', password: 'password', password_confirmation: 'password')
  end

  it "signs me in", :js => true do
    visit '/'
    find('#loginModelLink').click
    within("#loginModal") do
      fill_in 'Name', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Welcome back user@example.com!'
  end
end
