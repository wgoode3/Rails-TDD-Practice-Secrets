require 'rails_helper'
RSpec.describe 'signing up' do
  it 'prompts for valid fields' do
    visit '/users/new'
    expect(page).to have_field('user_email')
    expect(page).to have_field('user_name')
    expect(page).to have_field('user_password')
    expect(page).to have_field('user_password_confirmation')
  end
end