require 'rails_helper'

RSpec.feature 'Users Index Page' do
  before do
    User.create(
      name: 'Minion',
      photo: 'profile-image.png',
      bio: 'The first user in the BlogApp application.',
      posts_counter: 2
    )
    visit users_path
  end

  scenario 'displays the user name "Minion"' do
  expect(page).to have_content('Minion')
end

end
