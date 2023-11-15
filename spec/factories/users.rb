FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'Test@1234' }
  end
end
