require 'rails_helper'
RSpec.describe 'editing user' do
  it 'displays prepopulated form' do
    @user = User.create(name:"test", email:"test@test.test", password:"Test1234", password_confirmation:"Test1234")
    visit '/sessions/new'
    fill_in "user_email", with: "test@test.test"
    fill_in "user_password", with: "Test1234"
    click_button "Submit"
    click_link 'Edit Profile'
    expect(page).to have_field('Email')
    expect(page).to have_field('Name')
  end
end