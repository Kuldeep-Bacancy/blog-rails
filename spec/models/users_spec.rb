require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:black_list_tokens).dependent(:destroy) }
    it { should have_many(:articles).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }

    context 'email validation' do
      let(:user) { build_stubbed(:user, email: 'test@gmail.com') }
      let(:user_with_incorrect_email) { build_stubbed(:user, email: 'test.com') }

      it 'should not save email with existing email' do
        User.create(email: 'test@gmail.com', password: 'Test@1234')
        expect(user).to_not be_valid
      end

      it 'should not save email with wrong format' do
        expect(user_with_incorrect_email).to_not be_valid
      end

      it 'should save email with valid format' do
        expect(user).to be_valid
      end
    end
  end
end
