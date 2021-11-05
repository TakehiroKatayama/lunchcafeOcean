FactoryBot.define do
  factory :user do
    sequence(:name, 'name_1')
    sequence(:email) { |n| "user_#{n}@example.com" }
    sequence(:phonenumber) { |n| "090000000#{n}" }
    password { 'pass1111' }
    password_confirmation { 'pass1111' }
  end
end
