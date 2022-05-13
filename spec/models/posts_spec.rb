require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { create(:user) }

  describe "バリデーション" do
    describe "投稿成功" do
      it "タイトル、投稿内容、追加料金、カスタマイズレベル、画像があれば有効な事" do
        post = build(:post)
        expect(post).to be_valid
      end
    end

    describe "投稿失敗" do
      it "タイトルがなければ無効である事" do
        post = build(:post, title: nil)
        post.valid?
        expect(post.errors[:title]).to include "を入力してください"
      end

      it "投稿内容がなければ無効である事" do
        post = build(:post, content: nil)
        post.valid?
        expect(post.errors[:content]).to include "を入力してください"
      end

      it "ドリンクの種類がなければ無効である事" do
        post = build(:post, drink_type: nil)
        post.valid?
        expect(post.errors[:drink_type]).to include "を入力してください"
      end

      it "追加料金がなければ無効である事" do
        post = build(:post, extra_fee: nil)
        post.valid?
        expect(post.errors[:extra_fee]).to include "を入力してください"
      end

      it "カスタマイズレベルがなければ無効である事" do
        post = build(:post, change: nil)
        post.valid?
        expect(post.errors[:change]).to include "を入力してください"
      end

      it "画像がなければ無効である事" do
        post = build(:post, image: nil)
        post.valid?
        expect(post.errors[:image]).to include "を入力してください"
      end
    end
  end
end
