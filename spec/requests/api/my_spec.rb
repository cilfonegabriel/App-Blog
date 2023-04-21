# spec/requests/api/comments_spec.rb
require 'swagger_helper'

describe 'Comments API' do
  path '/api/posts/{post_id}/comments' do
    post 'Creates a comment' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :post_id, in: :path, type: :integer, required: true
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          author_id: { type: :integer },
          text: { type: :string }
        },
        required: [ 'author_id', 'text' ]
      }

      response '201', 'comment created' do
        let(:comment) { { author_id: 1, text: 'Great post!' } }
        let(:post_id) { Post.create(title: 'Test post', body: 'Test body').id }
        run_test!
      end

      response '422', 'invalid request' do
        let(:comment) { { author_id: nil, text: 'Great post!' } }
        let(:post_id) { Post.create(title: 'Test post', body: 'Test body').id }
        run_test!
      end
    end
  end
end