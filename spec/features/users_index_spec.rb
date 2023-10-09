require 'rails_helper'

RSpec.feature 'Users Index Page' do
  let(:users_data) do
    [
      {
        name: 'Minion',
        photo: 'profile-image.png',
        bio: 'The first user in the BlogApp application.',
        posts_counter: 2
      },
      {
        name: 'Riley',
        photo: 'profile-image.png',
        bio: 'A second user in the BlogApp application.',
        posts_counter: 2
      }
    ]
  end

  before do
    users_data.each do |user_data|
      User.create(user_data)
    end

    visit users_path
  end

  scenario 'displays user information' do
    users_data.each do |user_data|
      # expect(page).to have_css('user-image')
      expect(page).to have_content(user_data[:name])
      expect(page).to have_content(user_data[:posts_counter])
    end
  end
end
