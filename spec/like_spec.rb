require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John Doe') }
  let(:post) { Post.create(title: 'My Post', text: 'Post body', author_id: user.id) }

  it 'should like existing post' do
    like = Like.new(user:)
    expect(like).not_to be_valid
    expect(like.errors[:post]).to include('must exist')
  end
  it 'should not like a post without a user' do
    like = Like.new
    expect(like).not_to be_valid
    expect(like.errors[:user]).to include('must exist')
  end
end
