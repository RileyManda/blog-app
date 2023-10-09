require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'users#index', type: :system do
  before do
    @users = [
      { photo: 'profile-image.png', name: 'Minion', posts_counter: '2' }
    ]
    @users.each do |user_params|
      User.create(user_params)
    end

    visit users_path
  end

  it 'shows the list of users with their name, image, and post count' do
    visit users_path
    puts page.body
    @users.each do |user|
      expect(page).to have_content(user[:name])
      expect(page).to have_selector("img[src='/assets/images/profile-image.png']")
      expect(page).to have_content(user[:posts_counter])
    end
  end
end
