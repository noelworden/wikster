FactoryGirl.define do

  factory :wiki do
    title RandomData.random_sentence
    body RandomData.random_paragraph
    user_id RandomData.random_user
  end

end