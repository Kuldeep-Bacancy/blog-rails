require 'rails_helper'

RSpec.describe 'sessions', type: :request do
  include JsonWebToken
  let!(:user) { create(:user, email: 'test@gmail.com', password: 'Test@1234') }
  let!(:token) { jwt_encode(user_id: user.id) }

  describe 'DELETE /api/v1/logout' do
    context 'with valid token' do
      it 'logout a user' do
        delete '/api/v1/logout', headers: { Authorization: "Bearer #{token}" }
        json_response = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json_response['messageType']).to eq('success')
        expect(json_response['message']).to eq(['Logout Successfully!'])
        expect(json_response['data']).to be_empty
        expect(BlackListToken.count).to eq(1)
      end
    end

    context 'with no token' do
      it 'should not logout user' do
        delete '/api/v1/logout'
        json_response = JSON.parse(response.body)
        expect(json_response['messageType']).to eq('error')
        expect(response.status).to eq(401)
        expect(json_response['data']).to be_empty
      end
    end
  end
end
