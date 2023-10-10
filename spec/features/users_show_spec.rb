require 'rails_helper'

RSpec.feature 'User Show Page' do
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

  scenario 'can see the users profile picture.' do
    users_data.each do |_users_data|
      expect(page).to have_css("img[src*='profile-image']")
    end
  end

  scenario 'can see the users username.' do
    expect(page).to have_content(users_data.first[:name])
  end

  scenario 'can see the number of posts the user has written.' do
    expect(page).to have_content(users_data.first[:posts_counter])
  end

  scenario 'can see the users bio.' do
    expect(page).to have_content(users_data.first[:bio])
  end

  # can see the user's first 3 posts

  scenario 'can see a button that lets me view all of a user\'s posts.' do
    expect(page).to have_link('See all posts', href: user_posts_path(User.first))
  end

  # When I click to see all posts, it redirects me to the user's post's index page.

  scenario 'click on see all posts a users post, redirects to that user\'s post\'s index page' do
    click_link('See all posts')
    expect(page).to have_current_path(user_posts_path(User.first))
  end

  # When I click a user's post, it redirects me to that post's show page.

  scenario 'click on a user\'s post, redirects to that post\'s show page' do
    click_link(posts_data.first[:title])
    expect(page).to have_current_path(user_post_path(User.first, Post.find_by(title: posts_data.first[:title])))
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
