require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let!(:comment) { build(:comment, user: user, post: post) }

  before do
    sign_in user
  end

  describe "表示テスト" do
    it "投稿詳細ページにコメントテーブルの情報が正しく表示されている事" do
      get post_path(post)
      expect(response.body).to include comment.comment_content
    end
  end
end
