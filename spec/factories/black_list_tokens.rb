# frozen_string_literal: true

FactoryBot.define do
  factory :black_list_token do
    token { SecureRandom.hex }
    association :user
  end
end
