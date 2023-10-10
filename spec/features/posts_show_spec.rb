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

  let(:comments_data) do
    [
      { text: 'This is a cool post' },
      { text: 'Second comment on post 17' },
      { text: '3rd comment on post 17' },
      { text: '4th comment on post 17' },
      { text: '5th comment on post 17' }

    ]
  end

  before do
    create_users_and_posts
    visit_user_show_page(User.first)
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
  scenario 'can see who wrote the post' do
    expect(page).to have_content(User.first.name)
  end
  scenario 'can see how many comments a post has' do
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
  scenario 'can see a post\'s body' do
    users_data.each_with_index do |user_data, index|
      user = User.find_by(name: user_data[:name])
      post_data = posts_data[index]
      post = user.posts.create(title: post_data[:title], text: post_data[:text])
      visit user_posts_path(user)
      expect(page).to have_content(post.text)
    end
  end
  scenario 'I can see the username of each commentor' do
    users_data.each_with_index do |user_data, index|
      user = User.find_by(name: user_data[:name])
      post_data = posts_data[index]
      post = user.posts.create(title: post_data[:title], text: post_data[:text])

      visit user_posts_path(user)

      next unless post.comments.any?

      post.comments.each do |comment|
        expect(page).to have_content(comment.user.name)
      end
    end
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
