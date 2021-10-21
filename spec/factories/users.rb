FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { 'password' }
    avatar { Rack::Test::UploadedFile.new('spec/support/assets/test-image.png', 'image/png') }
    approved { true }

    before :create do |user|
      user.skip_confirmation!
    end

    trait :admin do
      admin { true }
    end
  end
end
