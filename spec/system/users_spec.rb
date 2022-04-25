require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  let(:user_with_image) { create(:user, :with_image) }

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
          login(user)
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
  describe "ログイン後" do
    describe "ユーザー編集" do
      it "ユーザー編集に成功する事" do
        login(user)
        visit edit_user_path(user)
        fill_in "user[name]", with: "test_edit_user"
        fill_in "user[email]", with: "test_edit_user@example.com"
        attach_file "user[image]", "#{Rails.root}/spec/factories/test.jpg"
        click_on "更新する"
        expect(current_path).to eq user_path(user)
        expect(page).to have_content "ユーザー情報を編集しました。"
        expect(page).to have_selector "img[src$='test.jpg']"
      end
    end

    describe "パスワード編集" do
      it "パスワードの変更に成功する事" do
        login(user)
        visit edit_user_registration_path
        fill_in "user[password]", with: "test_password"
        fill_in "user[password_confirmation]", with: "test_password"
        fill_in "user[current_password]", with: user.password
        click_on "更新する"
        expect(current_path).to eq user_path(user)
        expect(page).to have_content "パスワードを変更しました。"
      end
    end

    describe "ログアウト機能" do
      it "ログアウトに成功する事" do
        login(user)
        click_on "ログアウト"
        expect(current_path).to eq root_path
        expect(page).to have_content "ログアウトに成功しました"
      end
    end
  end

  describe "表示テスト" do
    it "アイコン画像未登録の場合" do
      login(user)
      visit user_path(user)
      expect(page).to have_content user.name
      expect(page).to have_content user.email
      expect(page).to have_selector "img[src*='default_icon']"
    end

    context "アイコン画像登録済みの場合" do
      it "ユーザー情報が正しく表示されている事" do
        login(user_with_image)
        visit user_path(user_with_image)
        expect(page).to have_content user_with_image.name
        expect(page).to have_content user_with_image.email
        expect(page).to have_selector "img[src$='test.jpg']"
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

    it "パスワード設定は「こちら」をクリックすると、パスワード編集ページに遷移する" do
      login(user)
      visit edit_user_path(user)
      click_on "こちら"
      expect(current_path).to eq edit_user_registration_path
    end

    it "プロフィールの変更は「こちら」をクリックすると、ユーザー編集ページに遷移する" do
      login(user)
      visit edit_user_registration_path
      click_on "こちら"
      expect(current_path).to eq edit_user_path(user)
    end
  end
end
