require 'rails_helper'
RSpec.describe 'displaying likes' do
  before do
    @user = User.create(name:"test", email:"test@test.test", password:"Test1234", password_confirmation:"Test1234")
    visit '/sessions/new'
    fill_in "user_email", with: "test@test.test"
    fill_in "user_password", with: "Test1234"
    click_button "Submit"
    @secret1 = @user.secrets.create(content: 'Oops', user: @user)
    @secret2 = @user.secrets.create(content: 'I did it again', user: @user)
    Like.create(user: @user, secret: @secret1)
  end
  it 'displays unlike button for secrets already liked' do
    visit '/secrets'
    expect(page).to have_text(@secret1.content)
    expect(page).to have_text('1')
    expect(page).to have_button('Unlike')
    expect(page).to have_text(@secret2.content)
    expect(page).to have_text('1')
    expect(page).to have_button('Unlike')
  end
  it 'deletes like and displays the changes in both profile and secrets page' do
    visit '/secrets'
    click_button 'Unlike'
    expect(current_path).to eq("/secrets")
    expect(page).not_to have_button('Unlike')
    expect(page).not_to have_text('1 likes')
    visit "/users/#{@user.id}"
    expect(page).not_to have_text('1 likes')
  end
  it 'creates like and displays it both in profile and secrets page' do
    visit '/secrets'
    click_button 'Unlike'
    expect(current_path).to eq('/secrets')
    expect(page).not_to have_button('Like')
    expect(page).not_to have_text('0 likes')
    visit "/users/#{@user.id}"
    expect(page).not_to have_text('0 likes')
  end
end