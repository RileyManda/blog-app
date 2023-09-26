require 'rails_helper'
# test: Name must not be blank
RSpec.describe Post, type: :model do
  # Tittle must not be blank.
  it 'tittle must not be blank.' do
    post = Post.new(title: nil)
    expect(post).not_to be_valid
  end
  # Title must not exceed 250 characters.
  it 'title must not exceed 250 characters.' do
    post = Post.new(title: 'a' * 251)
    expect(post).not_to be_valid
  end
end
