# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe 'DELETE /api/v1/articles/:id' do
    include JsonWebToken
    let!(:user) { create(:user, email: 'test@gmail.com', password: 'Test@1234') }
    let!(:token) { jwt_encode(user_id: user.id) }
    let!(:article) { create(:article, user:) }

    it 'delete article' do
      delete "/api/v1/articles/#{article.id}", headers: { Authorization: "Bearer #{token}" }
      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json_response['messageType']).to eq('success')
      expect(Article.count).to eq(0)
    end
  end
end
