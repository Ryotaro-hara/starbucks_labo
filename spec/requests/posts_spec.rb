require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let!(:new_post) { create(:post, user: user) }

  describe "GET #index" do
    before do
      get root_path
    end

    it "レスポンスが正しく返ってくる事" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #new" do
    before do
      sign_in user
      get new_post_path
    end

    it "レスポンスが正しく返ってくる事" do
      expect(response).to have_http_status(200)  
    end
  end

  describe "POST #create" do
    let(:post_params) { attributes_for(:post) }
    let(:invalid_post_params) { attributes_for(:post, :invalid) }

    before do
      sign_in user
    end

    context "パラメーターが有効な場合" do
      it "データベースへの保存に成功する事" do
        expect{
          post posts_path, params: { post: post_params }
        }.to change(user.posts, :count).by(1)  
      end

      it "リダイレクトに成功する事" do
        post posts_path, params: { post: post_params }
        expect(response).to redirect_to root_path
      end
    end

    context "パラメーターが無効な場合" do
      it "データベースへの保存に失敗する事" do
        expect{
          post posts_path, params: { post: invalid_post_params }
        }.not_to change(user.posts, :count)
      end

      it "エラーが表示される事" do
        post posts_path, params: { post: invalid_post_params }
        expect(response.body).to include "新規投稿に失敗しました"
      end
    end
  end
end
