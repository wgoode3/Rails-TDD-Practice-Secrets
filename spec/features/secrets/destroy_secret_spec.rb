require 'rails_helper'
RSpec.describe 'deleting a secret' do
  before do
    @user = User.create(name:"test", email:"test@test.test", password:"Test1234", password_confirmation:"Test1234")
    visit '/sessions/new'
    fill_in "user_email", with: "test@test.test"
    fill_in "user_password", with: "Test1234"
    click_button "Submit"
    fill_in 'content', with: 'The Grand Tetons'
    click_button 'New Secret'
    expect(page).to have_text('The Grand Tetons')
  end
  it 'deletes secrets from profile page and redirects to profile page' do
    click_button 'Delete'
    expect(current_path).to eq("/users/#{@user.id}")
    expect(page).not_to have_text('The Grand Tetons')
  end
  it 'deletes secret from secrets index page and redirects to current user profile page' do
    visit '/secrets'
    click_button 'Delete'
    expect(current_path).to eq("/users/#{@user.id}")
    expect(page).not_to have_text('The Grand Tetons')
  end
end