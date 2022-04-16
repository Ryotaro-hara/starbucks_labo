require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe "ログイン前" do
    describe "アカウント新規登録" do
      context "フォームの入力値が正常" do
        it "ユーザー新規作成が成功する事" do
          visit new_user_registration_path
          fill_in "user[name]", with: "Example User"
          fill_in "user[email]", with: "user@example.com"
          fill_in "user[password]", with: "password"
          fill_in "user[password_confirmation]", with: "password"
          click_on "アカウント登録"
          expect(current_path).to eq root_path
          expect(page).to have_content "アカウント登録が完了しました"
        end
      end
      context "メールアドレスが未入力" do
        it "ユーザー新規作成が失敗する事" do
          visit new_user_registration_path
          fill_in "user[name]", with: "Example User"
          fill_in "user[email]", with: ""
          fill_in "user[password]", with: "password"
          fill_in "user[password_confirmation]", with: "password"
          click_on "アカウント登録"
          expect(current_path).to eq "/users"
          expect(page).to have_content "メールアドレスを入力してください"
        end
      end
    end
    describe "ログイン" do
      context "フォームの入力値が正常" do
        it "ログインが成功する事" do
          visit new_user_session_path
          fill_in "user[email]", with: user.email
          fill_in "user[password]", with: user.password
          click_on "ログイン"
          expect(current_path).to eq root_path
          expect(page).to have_content "ログインに成功しました"
        end
      end
      context "メールアドレス未入力" do
        it "ログインが失敗する事" do
          visit new_user_session_path
          fill_in "user[email]", with: ""
          fill_in "user[password]", with: user.password
          click_on "ログイン"
          expect(current_path).to eq new_user_session_path
          expect(page).to have_content "またはパスワードが違います"
        end
      end
    end
  end

  describe "ページ遷移テスト" do
    it "「ログインする」をクリックすると、ログインページに遷移する事" do
      visit new_user_registration_path
      click_on "ログインする"
      expect(current_path).to eq new_user_session_path
    end

    it "「新規登録する」をクリックすると、新規登録ページに遷移する事" do
      visit new_user_session_path
      click_on "新規登録する"
      expect(current_path).to eq new_user_registration_path
    end
  end
end
