require 'rails_helper'
RSpec.describe 'displaying likes' do
  before do
    @user = User.create(name:"test", email:"test@test.test", password:"Test1234", password_confirmation:"Test1234")
    visit '/sessions/new'
    fill_in "user_email", with: "test@test.test"
    fill_in "user_password", with: "Test1234"
    click_button "Submit"
    @secret = @user.secrets.create(content: 'poetry', user_id: @user.id)
    #Like.create(user: @user, secret: @secret)
  end
  it 'displays amount of likes next to each secret' do
    visit '/secrets'
    expect(page).to have_text(@secret.content)
    expect(page).to have_text('1')
    visit "/users/#{@user.id}"
    expect(page).to have_text(@secret.content)
    expect(page).to have_text('1')
  end
end