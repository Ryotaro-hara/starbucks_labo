FactoryBot.define do
  factory :comment do
    comment_content { "テスト投稿" }
    association :user
    association :post
  end
end
