require 'rails_helper'
RSpec.describe 'likes controller' do
  before do
  	@user = User.create(name:"test", email:"test@test.test", password:"Test1234", password_confirmation:"Test1234")
    visit '/sessions/new'
    fill_in "user_email", with: "test@test.test"
    fill_in "user_password", with: "Test1234"
    click_button "Submit"
    @secret = @user.secrets.create(content: 'meadhall', user_id: @user.id)
    click_button "Log Out"
  end
  it "when not logged in" do
  	visit '/secrets'
  	click_button "Like"
  	expect(current_path).to eq('/sessions/new')
  end
  it "only allows the correct user to destroy a like" do
  end
end