require 'rails_helper'
RSpec.describe 'logging in' do
  before do
    @user = User.create(name: "test", email: "test@test.test", password:"Test1234", password_confirmation:"Test1234")
  end
  it 'prompts for email and password' do
    visit '/sessions/new'
    expect(page).to have_field('user_email')
    expect(page).to have_field('user_password')
  end
  it 'logs in user if email/password combination is valid' do
    visit '/sessions/new'
    fill_in "user_email", with: "test@test.test"
    fill_in "user_password", with: "Test1234"
    click_button "Submit"
    expect(current_path).to eq("/users/#{@user.id}")
    expect(page).to have_text(@user.name)
  end
  it 'does not sign in user if email/password combination is invalid' do
    visit '/sessions/new'
    fill_in "user_email", with: "test@test.test"
    fill_in "user_password", with: "Password"
    click_button "Submit"
    expect(page).to have_text('Password does not match!')
  end
end