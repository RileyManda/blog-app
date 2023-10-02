require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:first_user) { User.create(name: 'John Doe', bio: 'Sample bio') }
  let(:first_post) { Post.create(id: 1, author: first_user, title: 'Sample Post', text: 'Sample Post') }

  describe 'GET /posts' do
    it 'returns a 200 OK response' do
      get posts_path
      expect(response).to have_http_status(200)
    end

    it "renders the 'posts/index' template" do
      get posts_path
      expect(response).to render_template('posts/index')
    end

    it "contains 'Posts List' in the response body" do
      get posts_path
      expect(response.body).to include('Posts List')
    end
  end

  describe 'GET #show' do
    it 'returns a 200 OK response' do
      get post_path(first_post)
      expect(response).to have_http_status(200)
    end

    it "renders the 'posts/show' template" do
      get post_path(first_post)
      expect(response).to render_template('posts/show')
    end

    it "contains 'Post Details' in the response body" do
      get post_path(first_post)
      expect(response.body).to include('Post Details')
    end
  end
end
