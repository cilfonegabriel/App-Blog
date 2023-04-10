require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'Get id' do
    it 'returns a successful response' do
      get users_path
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'renders the show template' do
      get '/users/:id'
      expect(response).to render_template(:show)
    end

    it ' includes the correct placeholder text in the response body' do
      get '/users/'
      expect(response.body).to include('Users#index')
    end
  end
end