require 'rails_helper'
RSpec.describe 'user profile page' do
  before do
    @user = User.create(name:"test", email:"test@test.test", password:"Test1234", password_confirmation:"Test1234")
    visit '/sessions/new'
    fill_in "user_email", with: "test@test.test"
    fill_in "user_password", with: "Test1234"
    click_button "Submit"
  end
  it "displays a user's secrets on profile page" do
    secret = Secret.create(content: 'abacas', user: @user)
    visit "/users/#{@user.id}"
    expect(page).to have_text("abacas")
  end
  it "displays everyone's secrets" do
    user2 = User.create(name:"Jeb", email:"jeb@kerman.kb", password:"Test1234", password_confirmation:"Test1234")
    secret1 = Secret.create(content: 'hash browns', user: @user)
    secret2 = Secret.create(content: 'tritium', user: user2)
    visit '/secrets'
    expect(page).to have_text("#{secret1.content}")
    expect(page).to have_text("#{secret2.content}")
  end
end