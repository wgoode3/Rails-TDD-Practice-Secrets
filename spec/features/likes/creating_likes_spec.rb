require 'rails_helper'
RSpec.describe 'creating likes' do
  before do
    @user = User.create(name:"test", email:"test@test.test", password:"Test1234", password_confirmation:"Test1234")
    visit '/sessions/new'
    fill_in "user_email", with: "test@test.test"
    fill_in "user_password", with: "Test1234"
    click_button "Submit"
    @secret = @user.secrets.create(content: 'meadhall', user_id: @user.id)
  end
  it 'creates like and displays it both in profile and secrets page' do
    visit '/secrets'
    expect(page).to have_text('1')
    click_button 'Unlike'
    expect(current_path).to eq('/secrets')
    expect(page).to have_text('0')
    visit "/users/#{@user.id}"
    expect(page).to have_text('0')
  end
end