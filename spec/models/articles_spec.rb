require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'associations' do
    it { should have_one_attached(:image) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:slug) }
  end
end
