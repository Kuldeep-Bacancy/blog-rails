# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe 'GET /index' do
    include JsonWebToken
    let!(:user) { create(:user, email: 'test@gmail.com', password: 'Test@1234') }
    let!(:token) { jwt_encode(user_id: user.id) }
    let!(:article1) { create(:article, user:) }
    let!(:article2) { create(:article, user:) }

    it 'returns all articles' do
      get '/api/v1/articles', headers: { Authorization: "Bearer #{token}" }
      json_response = JSON.parse(response.body)
      expect(json_response['data'].length).to eq(2)
      expect(Article.count).to eq(2)
      expect(response).to have_http_status(:success)
    end
  end
end
