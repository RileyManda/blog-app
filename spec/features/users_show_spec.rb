require 'rails_helper'

RSpec.feature 'User Show Page' do
  let(:user) do
    User.create(
      name: 'Minion',
      photo: 'profile-image.png',
      bio: 'The second user in the BlogApp application.',
      posts_counter: 3
    )
  end
  let!(:post1) do
    user.posts.create(
      title: 'First Post',
      text: 'Riley\'s first post',
      comments_counter: 0,
      likes_counter: 0
    )
  end
  let!(:post2) do
    user.posts.create(
      title: 'Second Post',
      text: 'Riley\'s second post',
      comments_counter: 0,
      likes_counter: 0
    )
  end
  let!(:post3) do
    user.posts.create(
      title: 'Rileys Third Post',
      text: 'Third post by Riley',
      comments_counter: 0,
      likes_counter: 0
    )
  end
  before do
    visit user_path(user)
  end
  scenario 'displays user bio' do
    expect(page).to have_content(user.bio)
  end
  scenario 'displays user posts with comments and likes' do
    expect(page).to have_content('First Post')
    expect(page).to have_content("Riley's first post")
    expect(page).to have_content('Comments: 0')
    expect(page).to have_content('Likes: 0')
    expect(page).to have_content('Second Post')
    expect(page).to have_content("Riley's second post")
    expect(page).to have_content('Comments: 0')
    expect(page).to have_content('Likes: 0')
    expect(page).to have_content('Rileys Third Post')
    expect(page).to have_content('Third post by Riley')
    expect(page).to have_content('Comments: 0')
    expect(page).to have_content('Likes: 0')
  end
end 