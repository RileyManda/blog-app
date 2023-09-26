require 'rails_helper'
# test: Name must not be blank
RSpec.describe User, type: :model do
  # name should not be empty
  it 'name should bnot be empty' do
    user = User.new(name: nil)
    expect(user).not_to be_valid
  end

end
