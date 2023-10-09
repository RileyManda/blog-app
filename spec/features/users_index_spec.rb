require 'rails_helper'

RSpec.feature 'Users Index Page' do
  let(:users_data) do
    [
      { name: 'Minion',
        photo: 'profile-image.png',
        bio: 'The first user in the BlogApp application.',
        posts_counter: 2 },
      { name: 'Riley',
        photo: 'profile-image.png',
        bio: 'A second user in the BlogApp application.',
        posts_counter: 3 }
    ]
  end

  before do
    users_data.each { |user_data| User.create(user_data) }
    visit users_path
  end

  scenario 'expect #index to display view title' do
    expect(page).to have_content('Users')
  end

  scenario 'displays users information' do
    users_data.each do |user_data|
      expect(page).to have_content(user_data[:name])
      expect(page).to have_content(user_data[:posts_counter])
      expect(page).to have_css("img[src*='profile-image']")
    end
  end
end
