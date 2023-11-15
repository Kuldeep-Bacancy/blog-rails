FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    password { 'Test@1234' }
  end
end