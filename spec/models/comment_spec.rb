require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let!(:comment) { build(:comment, user: user, post: post) }

  describe "POST /#create" do
    context "コメントを保存できる場合" do
      it "リクエストに成功する事" do
        expect(comment).to be_valid
      end
    end

    context "コメントを保存できない場合" do
      it "コメントが空では投稿できない" do
        comment.comment_content = nil
        comment.valid?
        expect(comment.errors.full_messages).to include "Comment contentを入力してください"
      end

      it "ユーザーがログインしていなければコメントできない" do
        comment.user_id = nil
        comment.valid?
        expect(comment.errors.full_messages).to include "Userを入力してください"
      end

      it "投稿したものがなければコメントできない" do
        comment.post_id = nil
        comment.valid?
        expect(comment.errors.full_messages).to include "Postを入力してください"
      end
    end
  end
end
