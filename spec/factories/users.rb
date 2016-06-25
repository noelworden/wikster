FactoryGirl.define do
  pw = RandomData.random_sentence

  factory :user do
    username RandomData.random_username
    sequence(:email){|n| "user#{n}@factory.com"}
    password pw
    password_confirmation pw
    confirmed_at "2016-06-25 15:26:01"
  end

end