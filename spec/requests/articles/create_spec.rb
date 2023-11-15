require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  include JsonWebToken
  let!(:user) { create(:user, email: 'test@gmail.com', password: 'Test@1234') }
  let!(:token) { jwt_encode(user_id: user.id) }

  let(:valid_attributes) do
    {
      "title": 'Ruby on Rails',
      "slug": 'ruby-on-rails',
      "content": 'Ruby on Rails is the best framework',
      "user_id": user.id
    }
  end

  let(:invalid_attributes) do
    {
      "title": '',
      "slug": 'ruby-on-rails',
      "content": 'Ruby on Rails is the best framework',
      "user_id": user.id
    }
  end

  describe 'POST /api/v1/logout' do
    context 'with valid parameters' do
      it 'logout a user' do
        post '/api/v1/articles', params: { "article": valid_attributes }, headers: { Authorization: "Bearer #{token}" }
        json_response = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json_response['messageType']).to eq('success')
        expect(json_response['message']).to eq(['Article Saved Successfully!'])
        expect(Article.count).to eq(1)
      end
    end

    context 'with invalid parameters' do
      it 'should not logout user' do
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
