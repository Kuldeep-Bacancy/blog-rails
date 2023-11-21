# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'registrations', type: :request do
  let(:valid_attributes) do
    {
      "email": 'test@gmail.com',
      "password": 'Test@1234'
    }
  end

  let(:invalid_attributes) do
    {
      "email": '',
      "password": 'Test@1234'
    }
  end

  describe 'POST /api/v1/signup' do
    context 'with valid parameters' do
      it 'creates a user' do
        post '/api/v1/signup', params: { user: valid_attributes }
        json_response = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json_response['messageType']).to eq('success')
        expect(User.count).to eq(1)
        expect(User.last.email).to eq('test@gmail.com')
      end
    end

    context 'with invalid parameters' do
      it 'should not create user' do
        post '/api/v1/signup', params: { user: invalid_attributes }
        json_response = JSON.parse(response.body)
        expect(json_response['messageType']).to eq('error')
        expect(response.status).to eq(422)
        expect(json_response['message']).to include("Email can't be blank", 'Email is invalid')
        expect(User.count).to eq(0)
      end
    end
  end
end
