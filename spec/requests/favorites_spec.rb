require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let(:user) { create(:user) }
  let(:post_new) { create(:post, user: user) }
  let(:favorite) { create(:favorite, user: user, post: post_new) }

  before do
    sign_in user
  end

  describe "POST /#create" do
    it "データの保存に成功する事" do
      expect do
        post post_favorites_path(post_new.id), xhr: true
      end.to change { Favorite.count }.by(1)
    end
  end

  describe "DELETE #destroy" do
    let!(:favorite) { create(:favorite, user: user, post: post_new) }  
    
    it "データの保存に成功する事" do
      expect do
        delete post_favorites_path(post_new.id), xhr: true
      end.to change { Favorite.count }.by(-1)
    end
  end
end
