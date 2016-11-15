require 'rails_helper'
RSpec.describe 'creating a secret' do
  it 'creates a new secret and redirects to profile page' do
    user = User.create(name:"test", email:"test@test.test", password:"Test1234", password_confirmation:"Test1234")
    visit '/sessions/new'
    fill_in "user_email", with: "test@test.test"
    fill_in "user_password", with: "Test1234"
    click_button "Submit"
    fill_in 'content', with: 'Abacas'
    click_button 'New Secret'
    expect(current_path).to eq("/users/#{user.id}")
    expect(page).to have_text('Abacas')
  end
end