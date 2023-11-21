# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { Faker::Quote.matz }
    slug { 'test' }
    content { Faker::Address.full_address }
    association :user
  end
end
