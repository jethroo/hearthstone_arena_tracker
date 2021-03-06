module FeaturesHelper
  def signed_in_user
    user = dummy_user
    visit '/'
    find('#loginModalLink').click
    within('#loginModal') do
      fill_in 'Name', with: user.name
      fill_in 'Password', with: user.password
    end
    click_button 'Log in'
    expect(page).to have_content 'Welcome back user@example.com!'
    user
  end

  def sign_out
    signed_in_user
    visit '/'
    find('#logoutLink').click
    expect(page).to have_content 'You have been logged out.'
  end

  private

  def dummy_user
    User.create(
      name: 'user@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end
end
