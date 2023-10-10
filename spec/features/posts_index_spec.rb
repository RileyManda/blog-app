require 'rails_helper'

RSpec.feature 'Posts Index Page' do
  let(:users_data) do
    [
      { name: 'Minion',
        photo: 'profile-image.png',
        bio: 'The first user in the BlogApp application.',
        posts_counter: 3 },

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
    users_data.each do |user_data|
      user = User.create(user_data)
      posts_data.each do |post_data|
        user.posts.create(post_data)
      end
    end
    visit users_path
  end

  scenario 'can see the users profile picture.' do
    users_data.each do |_users_data|
      expect(page).to have_css("img[src*='profile-image']")
    end
  end

  scenario 'can see the users username.' do
    expect(page).to have_content(users_data.first[:name])
  end

  scenario 'can see the number of posts the user has written on the users#index page' do
    users_data.each do |user_data|
      expect(page).to have_content("#{user_data[:name]}\nNumber of Posts: #{user_data[:posts_counter]}")
    end
  end

  scenario 'can see a post\'s title' do
    users_data.each_with_index do |user_data, index|
      user = User.find_by(name: user_data[:name])
      post_data = posts_data[index]
      post = user.posts.create(title: post_data[:title], text: post_data[:text])
      visit user_posts_path(user)
      expect(page).to have_content(post.title)
    end
  end

  # can see posts body
# TODO: scenario 'can see a post\'s body' do


  scenario 'can see the first comments on a post' do
    users_data.each_with_index do |user_data, index|
      user = User.find_by(name: user_data[:name])
      post_data = posts_data[index]
      post = user.posts.create(title: post_data[:title], text: post_data[:text])
      visit user_posts_path(user)
      if post.comments.any?
        first_comment = post.comments.first
        expect(page).to have_content(first_comment.text)
      else
        expect(page).to have_content('No comments for this post.')
      end
    end
  end

  scenario 'I can see how many comments a post has' do
    users_data.each_with_index do |user_data, index|
      user = User.find_by(name: user_data[:name])
      post_data = posts_data[index]
      post = user.posts.create(title: post_data[:title], text: post_data[:text])
      visit user_posts_path(user)
      if post.comments.any?
        expect(page).to have_content("Comments: #{post.comments.count}")
      else
        expect(page).to have_content('Comments: 0')
      end
    end
  end

  scenario 'I can see how many likes a post has' do
    users_data.each_with_index do |user_data, index|
      user = User.find_by(name: user_data[:name])
      post_data = posts_data[index]
      post = user.posts.create(title: post_data[:title], text: post_data[:text])
      visit user_posts_path(user)
      expect(page).to have_content("Likes: #{post.likes.count}")
    end
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view' do
    user = User.first
    post_count = user.posts.count

    visit user_posts_path(user)

    if post_count > 3
      expect(page).to have_selector('.pagination-button')
    else
      expect(page).not_to have_selector('.pagination-button')
    end
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
