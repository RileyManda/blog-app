require 'rails_helper'

RSpec.feature 'Posts Index Page' do
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

  let(:posts_data) do
    [
      {
        title: 'Minions First Post',
        text: 'Minions First Post ever',
        comments_counter: 5,
        likes_counter: 2
      },
      {
        title: 'Minions 2nd Post',
        text: 'I am the minion throwing out a 2nd post',
        comments_counter: 2,
        likes_counter: 1
      },
      {
        title: 'Minions Third Post',
        text: 'I am minion and this is my third post',
        comments_counter: 0,
        likes_counter: 0
      }
    ]
  end

  before do
    create_users_and_posts
  end

  scenario 'redirects to the user\'s post index page when clicking to see all posts' do
    visit_user_show_page(User.first)
    click_link('See all posts')
    expect(page).to have_current_path(user_posts_path(User.first))
  end

  private

  def create_users_and_posts
    users_data.each do |user_data|
      user = User.create(user_data)
      posts_data.each { |post_data| user.posts.create(post_data) }
    end
  end

  def visit_user_show_page(user)
    visit user_path(user)
  end
end
