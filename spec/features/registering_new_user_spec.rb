require 'rails_helper'

describe 'registering as new user', type: :feature do
  let(:user) do
    User.new(
      name: 'new_user',
      password: 'secret',
      password_confirmation: 'secret'
    )
  end

  it 'with the link presented in login modal', js: true do
    visit '/'
    find('#loginModalLink').click
    click_link 'Sign up now!'
    within('#new_user') do
      fill_in 'Name', with: user.name
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password_confirmation
      click_button 'Sign up'
    end
    expect(page).to have_content "Welcome on board #{user.name}"
  end
end
