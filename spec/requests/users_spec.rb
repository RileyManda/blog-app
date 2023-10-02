require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:first_user) { User.create(name: 'John Doe', bio: 'Sample bio') }
  describe 'GET /users' do
    it 'to render withouth errors' do
      get users_path
      expect(response).to have_http_status(200)
    end
  end
  it "renders the 'users/index' template" do
    get users_path
    expect(response).to render_template('users/index')
  end
  it "contains 'Users List' in the response body" do
    get users_path
    expect(response.body).to include('User List')
  end
end
describe 'GET #show' do
  it 'returns a 200 OK response' do
    user = User.create(name: 'Sample User', bio: 'Sample bio')
    get user_path(user)
    expect(response).to have_http_status(200)
  end
  it "renders the 'users/show' template" do
    user = User.create(name: 'Sample User', bio: 'Sample bio')
    get user_path(user)
    expect(response).to render_template('users/show')
  end
  it "contains 'User Details' in the response body" do
    user = User.create(name: 'Sample User', bio: 'Sample bio')
    get user_path(user)
    expect(response.body).to include('User details')
  end
end
