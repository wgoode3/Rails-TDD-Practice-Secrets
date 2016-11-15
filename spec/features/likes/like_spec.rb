require 'rails_helper'
RSpec.describe Like, type: :model do
  describe 'relationships' do
    before do
      @user = User.create(name:"test", email:"test@test.test", password:"Test1234", password_confirmation:"Test1234")
      @secret = @user.secrets.create(content: 'Oops', user_id: @user)
      @like = Like.create(user: @user, secret: @secret)
    end
    it 'belongs to a user' do
      expect(@like.user).to eq(@user)
    end
    it 'belongs to a secret' do
      expect(@like.secret).to eq(@secret)
    end
  end
end