
require 'rails_helper'
RSpec.describe 'updating user' do
  it 'updates user and redirects to profile page' do
    @user = User.create(name:"test", email:"test@test.test", password:"Test1234", password_confirmation:"Test1234")
    visit '/sessions/new'
    fill_in "user_email", with: "test@test.test"
    fill_in "user_password", with: "Test1234"
    click_button "Submit"
    click_link 'Edit Profile'
    expect(page).to have_text('test')
    fill_in 'Name', with: 'abacus'
    click_button 'Update'
    expect(page).not_to have_text('test')
    expect(page).to have_text('abacus')
  end
end