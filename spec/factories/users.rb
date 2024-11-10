FactoryBot.define do
  factory :user do
    username { "TestUser" }
    email { Faker::Internet.unique.email }
    password { "password" }
    password_confirmation { "password" }
    role { :general }
  end
end
