require 'rails_helper'

RSpec.describe 'sessions', type: :request do
  let!(:user) { create(:user, email: 'test@gmail.com', password: 'Test@1234') }
  let(:valid_attributes) do
    {
      "email": 'test@gmail.com',
      "password": 'Test@1234'
    }
  end

  let(:invalid_attributes) do
    {
      "email": 'test@gmail.com',
      "password": 'Test@12'
    }
  end

  describe 'POST /api/v1/login' do
    context 'with valid parameters' do
      it 'login a user' do
        post '/api/v1/login', params: { user: valid_attributes }
        json_response = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json_response['messageType']).to eq('success')
        expect(json_response['message']).to eq(['Sign in successfully'])
        expect(json_response['data']).to_not be_empty
        expect(json_response['data']).to have_key('token')
      end
    end

    context 'with invalid parameters' do
      it 'should not login user' do
        post '/api/v1/login', params: { user: invalid_attributes }
        json_response = JSON.parse(response.body)
        expect(json_response['messageType']).to eq('error')
        expect(response.status).to eq(203)
        expect(json_response['message']).to eq(['You entered in an incorrect email or password,please try again.'])
        expect(json_response['data']).to be_empty
      end
    end
  end
end
