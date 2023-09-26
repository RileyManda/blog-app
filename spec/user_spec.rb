require 'rails_helper'
# test: Name must not be blank
RSpec.describe User, type: :model do
  # Name must not be blank.
  it 'name must not be blank.' do
    user = User.new(name: nil)
    expect(user).not_to be_valid
  end
  # PostsCounter must be an integer greater than or equal to zero
  it 'postsCounter must be an integer greater than or equal to zero' do
    user = User.new(name: 'test', posts_counter: -1)
    expect(user).not_to be_valid
  end
end
