require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:first_user) { User.create(name: 'John Doe', bio: 'Sample bio') }

  describe 'GET /posts' do
    it 'returns a 200 OK response' do
      get posts_path
      expect(response).to have_http_status(200)
    end

    it "contains 'Posts List' in the response body" do
      get posts_path
      expect(response.body).to include('Posts List')
    end
    it "renders the 'posts/index' template" do
      get posts_path
      expect(response).to render_template('posts/index')
    end
  end
end
