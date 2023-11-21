# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  include JsonWebToken
  let!(:user) { create(:user, email: 'test@gmail.com', password: 'Test@1234') }
  let!(:token) { jwt_encode(user_id: user.id) }
  let!(:article) { create(:article, title: 'Ruby on Rails') }

  let(:valid_attributes) do
    {
      "title": 'New Ruby on Rails'
    }
  end

  let(:invalid_attributes) do
    {
      "title": ''
    }
  end

  describe 'POST /api/v1/articles' do
    context 'with valid parameters' do
      it 'create a article' do
        patch "/api/v1/articles/#{article.id}", params: { "article": valid_attributes },
                                                headers: { Authorization: "Bearer #{token}" }
        json_response = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json_response['messageType']).to eq('success')
        expect(json_response['data']['attributes']['title']).to eq('New Ruby on Rails')
      end
    end

    context 'with invalid parameters' do
      it 'should not article' do
        post '/api/v1/articles', params: { "article": invalid_attributes },
                                 headers: { Authorization: "Bearer #{token}" }
        json_response = JSON.parse(response.body)
        expect(json_response['messageType']).to eq('error')
        expect(json_response['message']).to include("Title can't be blank")
        expect(response.status).to eq(422)
        expect(json_response['data']).to be_empty
      end
    end
  end
end
