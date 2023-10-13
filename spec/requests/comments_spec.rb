# spec/requests/comments_spec.rb

require 'swagger_helper'

describe 'Comments API', type: :request do
   path '/users/{user_id}/posts/{post_id}/comments' do
    parameter name: 'user_id', in: :path, type: :integer, description: 'User ID'
    parameter name: 'post_id', in: :path, type: :integer, description: 'Post ID'

    get 'Retrieves comments for a post' do
      tags 'Comments'
      produces 'application/json'
      security [apiKey: []]

      response '200', 'comments found' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              text: { type: :string },
              user_id: { type: :integer },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            },
            required: ['id', 'text', 'user_id']
          }

        run_test!
      end

      response '404', 'post not found' do
        run_test!
      end
    end
  end
end
