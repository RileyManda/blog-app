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

  scenario 'expect #index to display view title' do
    expect(page).to have_content('Users')
  end

  scenario 'can see username of all users' do
    users_data.each do |user_data|
      expect(page).to have_content(user_data[:name])
    end
  end

  scenario 'can see the profile picture for each user.' do
    users_data.each do |_user_data|
      expect(page).to have_css("img[src*='profile-image']")
    end
  end

  scenario 'can see the number of posts each user has written.' do
    users_data.each do |user_data|
      expect(page).to have_content(user_data[:posts_counter])
    end
  end

  scenario 'when clicking on a user, I am redirected to that user\'s show page' do
    user_name = users_data.first[:name]
    click_link(user_name)
    expect(page).to have_current_path(user_path(User.find_by(name: user_name)))
  end
end
