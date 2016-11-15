require 'rails_helper'
RSpec.describe 'new secret' do
  it 'provides form in user profile page to create a new secret' do
    user = User.create(name:"test", email:"test@test.test", password:"Test1234", password_confirmation:"Test1234")
    visit '/sessions/new'
    fill_in "user_email", with: "test@test.test"
    fill_in "user_password", with: "Test1234"
    click_button "Submit"
    expect(page).to have_text("Create new secret:")
    expect(page).to have_field('content')
  end
end