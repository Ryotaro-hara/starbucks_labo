require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }

  it "新規登録ページへのレスポンスが正しく返ってくる事" do
    get new_user_registration_path
    expect(response).to have_http_status(200)
  end

  it "ログインページへのレスポンスが正しく返ってくる事" do
    get new_user_session_path
    expect(response).to have_http_status(200)
  end
end
