FactoryGirl.define do
  factory :user do
    name     "Caleb Wang"
    email    "caleb@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end