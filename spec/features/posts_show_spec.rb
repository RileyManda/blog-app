require 'rails_helper'

RSpec.feature 'Posts Show Page' do
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
    visit_user_show_page(User.first)
  end

  scenario 'displays users profile picture' do
    users_data.each do |_users_data|
      expect(page).to have_css("img[src*='profile-image']")
    end
  end

  scenario 'displays user name' do
    expect(page).to have_content(users_data.first[:name])
  end

  scenario 'displays number of posts user has written' do
    expect(page).to have_content(users_data.first[:posts_counter])
  end

  scenario 'displays user bio' do
    expect(page).to have_content(users_data.first[:bio])
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

  def expect_posts_to_be_displayed(posts)
    posts.each do |post_data|
      expect(page).to have_content(post_data[:title])
      expect(page).to have_content(post_data[:text])
      expect(page).to have_content("Comments: #{post_data[:comments_counter]}")
      expect(page).to have_content("Likes: #{post_data[:likes_counter]}")
    end
  end
end
