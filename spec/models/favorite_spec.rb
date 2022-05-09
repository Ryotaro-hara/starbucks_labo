require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let!(:favorite) { create(:favorite, post: post, user: user) }

  describe "バリデーション" do
    it "1つの投稿に複数のいいねができない事" do
      another_favorite = build(:favorite, post: post, user: user)
      another_favorite.valid?
      expect(another_favorite.errors.full_messages).to include "Postはすでに存在します"
    end  
  end
end
