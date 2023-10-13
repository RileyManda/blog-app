require 'swagger_helper'

describe 'Posts API' do
  path '/api/v1/users/{user_id}/posts' do
    get 'Retrieves a list of posts for a user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer

      response '200', 'list of posts' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   text: { type: :string },
                   comments_counter: { type: :integer },
                   likes_counter: { type: :integer }
                 },
                 required: %w[id title text]
               }

        let(:user_id) { User.create(name: 'John', email: 'john@example.com', password: 'password').id }
        run_test!
      end

      response '404', 'user not found' do
        let(:user_id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/posts/{id}' do
    get 'Retrieves a single post for a user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      parameter name: :id, in: :path, type: :integer

      response '200', 'post found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 text: { type: :string }
               },
               required: %w[id title text]

        let(:user_id) { User.create(name: 'John', email: 'john@example.com', password: 'password').id }
        let(:id) { Post.create(title: 'Post Title', text: 'Post Text').id }
        run_test!
      end

      response '404', 'post not found' do
        let(:user_id) { 'invalid' }
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
