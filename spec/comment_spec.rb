require 'rails_helper'
RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John Doe') }
  let(:post) { Post.create(title: 'My Post', text: 'Post body', author_id: user.id) }
  # comment text should not be blank
  it 'comment text should not be blank' do
    comment = Comment.new(text: nil)
    expect(comment).not_to be_valid
  end
  # should return the comment text
  it 'should return the comment text' do
    comment = Comment.new(text: 'test')
    expect(comment.text).to eq('test')
  end
  # is valid with valid attributes
  it 'is valid with valid attributes' do
    comment = Comment.new(user:, post:, text: 'A valid comment')
    expect(comment).to be_valid
  end
  # is not valid without a post
  it 'is not valid without a post' do
    post = Post.create(author: user, title: 'My Post', text: 'This is my post')
    comment = Comment.new(user:, text: 'Comment without a post', post:)
    expect(comment).to be_valid
  end
end
