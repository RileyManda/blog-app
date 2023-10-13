require 'swagger_helper'
RSpec.describe 'Comments API' do
  path '/api/v1/comments' do
    get 'Retrieves all comments' do
      tags 'Comments'
      produces 'application/json'
      response '200', 'comments found' do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   text: { type: :string }
                 },
                 required: %w[id text]
               }
        run_test!
      end
    end
    post 'Creates a comment' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string, example: 'This is a comment' }
        },
        required: ['text']
      }
      response '201', 'comment created' do
        let(:comment) { { text: 'This is a comment' } }
        run_test!
      end
      response '422', 'invalid request' do
        let(:comment) { { text: '' } }
        run_test!
      end
    end
  end
  path '/api/v1/comments/{id}' do
    # Define the 'show' endpoint documentation
    get 'Retrieves a comment' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      response '200', 'comment found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 text: { type: :string }
               },
               required: %w[id text]
        let(:id) { Comment.create(text: 'This is a comment').id }
        run_test!
      end
      response '404', 'comment not found' do
        let(:id) { 'invalid' } # Example of a non-existent comment
        run_test!
      end
    end
    delete 'Deletes a comment' do
      tags 'Comments'
      parameter name: :id, in: :path, type: :string
      response '204', 'comment deleted' do
        let(:id) { Comment.create(text: 'This is a comment').id }
        run_test!
      end
      response '404', 'comment not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
