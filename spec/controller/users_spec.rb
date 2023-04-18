require 'rails_helper'
RSpec.describe 'Users', type: :request do
  before(:each) do
    @user1 = User.create(
      name: 'User 1',
      photo: 'https://unsplash.com/photos/Hekapoo',
      bio: 'User 1 bio',
      posts_counter: 0
    )
  end

  describe 'GET /index' do
    it 'returns http success' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'returns render index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'body includes correct placeholder text' do
      get users_path
      expect(response.body).to include(@user1.name)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get users_path(@user1)
      expect(response).to have_http_status(:success)
    end

    it 'returns render show template' do
      get user_path(@user1)
      expect(response).to render_template(:show)
    end

    it 'body includes correct photo text' do
      get users_path
      expect(response.body).to include(@user1.name)
    end
  end
end
