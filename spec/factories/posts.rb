FactoryBot.define do
  factory :post do
    title { "テスト投稿" }
    content { "テスト用投稿内容" }
    extra_fee { 1 }
    change { "ちょい変" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/post.test.png'))}
    association :user

    trait :invalid do
      title { nil }
    end
  end
end
