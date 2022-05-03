require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let!(:new_post) { create(:post, user: user) }

  describe "GET #index" do
    before do
      get root_path
    end

    it "リクエストが成功する事" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #new" do
    before do
      sign_in user
      get new_post_path
    end

    it "リクエストが成功する事" do
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
      it "リクエストが成功する事" do
        post posts_path, params: { post: post_params }
        expect(response).to have_http_status(302)
      end

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
      it "リクエストが成功する事" do
        post posts_path, params: { post: invalid_post_params }
        expect(response).to have_http_status(200)  
      end

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

  describe "GET #show" do
    it "リクエストが成功する事" do
      sign_in user
      get post_path(new_post)
      expect(response).to have_http_status(200)
    end

    it "未ログインの場合、正常なレスポンスが返ってこない事" do
      get post_path(new_post)
      expect(response).not_to have_http_status(200)
    end
  end

  describe "GET #edit" do
    before do
      sign_in user
      get edit_post_path(new_post)
    end

    it "リクエストが成功する事" do
      expect(response).to have_http_status(200)
    end

    it "編集前のデータが表示されている事" do
      expect(response.body).to include new_post.title
      expect(response.body).to include new_post.content
      expect(response.body).to include new_post.extra_fee.to_s
      expect(response.body).to include new_post.change
    end
  end

  describe "PATCH #update" do
    before do
      sign_in user
    end

    context "パラメーターが正常な場合" do
      let!(:post_params) { attributes_for(:post, title: "other") }

      it "リクエストが成功する事" do
        patch post_path(new_post), params: { post: post_params }
        expect(response).to have_http_status(302)
      end

      it "titleが更新される事" do
        expect { 
          patch post_path(new_post), params: { post: post_params }
        }.to change { new_post.reload.title }.from("テスト投稿").to("other")
      end
    end

    context "パラメーターが異常な場合" do
      let(:invalid_post_params) { attributes_for(:post, :invalid) }
      
      it "リクエストが成功する事" do
        patch post_path(new_post), params: { post: invalid_post_params }
        expect(response).to have_http_status(200)  
      end

      it "titleが更新されない事" do
        expect { 
          patch post_path(new_post), params: { post: invalid_post_params }
        }.not_to change(new_post.reload, :title)
      end

      it "エラーが表示される事" do
        patch post_path(new_post), params: { post: invalid_post_params }
        expect(response.body).to include "投稿の編集に失敗しました"  
      end
    end
  end
end
