require 'rails_helper'
RSpec.describe 'user profile page' do
  before do
    @user = User.create(name:"test", email:"test@test.test", password:"Test1234", password_confirmation:"Test1234")
    visit '/sessions/new'
    fill_in "user_email", with: "test@test.test"
    fill_in "user_password", with: "Test1234"
    click_button "Submit"
  end
  it 'displays information about the user' do
    expect(page).to have_text("#{@user.name}")
    expect(page).to have_link('Edit Profile')
  end
end