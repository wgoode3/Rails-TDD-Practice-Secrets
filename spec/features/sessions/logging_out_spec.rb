require 'rails_helper'
RSpec.describe 'logging out' do
  before do
    @user = User.create(name: "test", email: "test@test.test", password:"Test1234", password_confirmation:"Test1234")
    visit '/sessions/new'
    fill_in "user_email", with: "test@test.test"
    fill_in "user_password", with: "Test1234"
    click_button "Submit"
  end
  it 'displays "Log Out" button when user is logged on' do
    expect(page).to have_button('Log Out')
  end
  it 'logs out user and redirects to login page' do
    click_button 'Log Out'
    expect(current_path).to eq('/sessions/new')
  end
end