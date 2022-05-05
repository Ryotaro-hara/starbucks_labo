require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let!(:post) { create(:post, user: user) }
  let(:user) { create(:user) }

  describe "掲示板一覧ページ" do
    before do
      visit root_path
    end

    describe "表示テスト" do
      it "postsテーブルのデータが正しく表示されている事" do
        expect(page).to have_content post.title
        expect(page).to have_content post.change
        expect(page).to have_content post.created_at.to_s(:datetime_jp)
        expect(page).to have_selector "img[src$='post.test.png']"
      end

      describe "ログイン前" do
        it "ヘッダーに「新規登録」「ログイン」が表示されている事" do
          within ".navbar" do
            expect(page).to have_content "ログイン"
            expect(page).to have_content "新規登録"
          end
        end 
      end

      describe "ログイン後" do
        before do
          login(user)
        end

        it "ヘッダーに「ホーム」「新規投稿」「マイページ」「ログアウト」が表示されている事" do
          within ".navbar" do
            expect(page).to have_content "ホーム"
            expect(page).to have_content "新規投稿"
            expect(page).to have_content "マイページ"
            expect(page).to have_content "ログアウト"
          end
        end
      end
    end

    describe "ページ遷移テスト" do
      describe "ログイン前" do
        it "ヘッダーの「新規登録」をクリックすると新規登録ページに遷移する事" do
          within ".navbar" do
            click_on "新規登録"
          end
          expect(current_path).to eq new_user_registration_path
        end

        it "ヘッダーの「ログイン」をクリックするとログインページに遷移する事" do
          within ".navbar" do
            click_on "ログイン"
          end
          expect(current_path).to eq new_user_session_path
        end
      end

      describe "ログイン後" do
        before do
          login(user)
        end

        it "ヘッダーの「ホーム」をクリックすると掲示板一覧ページに遷移する事" do
          within ".navbar" do
            click_on "ホーム"
          end
          expect(current_path).to eq root_path
        end

        it "ヘッダーの「新規投稿」をクリックすると新規投稿ページに遷移する事" do
          within ".navbar" do
            click_on "新規投稿"
          end
          expect(current_path).to eq new_post_path
        end

        it "ヘッダーの「マイページ」をクリックするとユーザー詳細ページに遷移する事" do
          within ".navbar" do
            click_on "マイページ"
          end
          expect(current_path).to eq user_path(user)
        end

        it "ヘッダーの「ログアウト」をクリックすると掲示板一覧ページに遷移する事" do
          within ".navbar" do
            click_on "ログアウト"
          end
          expect(current_path).to eq root_path
        end

        it "投稿をクリックすると投稿詳細ページに遷移する事" do
          click_on post.title
          expect(current_path).to eq post_path(post)
        end
      end
    end
  end

  describe "新規投稿ページ" do    
    before do
      login(user)
      visit new_post_path
    end

    describe "表示テスト" do
      it "投稿ボタンが「ドリンクを投稿する」という表記になっている事" do
        expect(page).to have_button "ドリンクを投稿する"
      end
    end
    
    describe "遷移テスト" do
      context "フォーム入力値が正常" do
        it "新規投稿に成功する事" do
          fill_in "post_title", with: "test_title"
          fill_in "post_content", with: "test_content"
          fill_in "post_extra_fee", with: 1
          choose "post_change_ちょい変"
          attach_file "post[image]", "#{Rails.root}/spec/factories/post.test.png"
          click_on "ドリンクを投稿する"
          expect(current_path).to eq root_path
          expect(page).to have_content "新規投稿に成功しました"
        end
      end

      context "タイトルが未入力" do
        it "新規投稿に失敗する事" do
          fill_in "post_title", with: nil
          fill_in "post_content", with: "test_content"
          fill_in "post_extra_fee", with: 1
          choose "post_change_ちょい変"
          attach_file "post[image]", "#{Rails.root}/spec/factories/post.test.png"
          click_on "ドリンクを投稿する"
          expect(current_path).to eq posts_path
          expect(page).to have_content "新規投稿に失敗しました"
          expect(page).to have_content "タイトルを入力してください"
        end
      end
    end
  end

  describe "投稿詳細ページ" do
    describe "表示テスト" do
      it "postsテーブルのデータが正しく表示されている事" do
        login(user)
        visit post_path(post)
        expect(page).to have_content post.title
        expect(page).to have_content post.content
        expect(page).to have_content post.change
        expect(page).to have_content post.extra_fee
        expect(page).to have_content post.created_at.to_s(:datetime_jp)
        expect(page).to have_selector "img[src$='post.test.png']"
      end

      describe "ユーザー表示テスト" do
        describe "ユーザー画像未登録の場合" do
          it "投稿したユーザーの情報が正しく表示されている事" do
            login(user)
            visit post_path(post)
            expect(page).to have_content post.user.name
            expect(page).to have_selector "img[src*='default_icon']"
          end
        end

        describe "ユーザーが画像登録済みの場合" do
          let!(:post) { create(:post, user: user_with_image) }
          let(:user_with_image) { create(:user, :with_image) }

          it "投稿したユーザーの情報が正しく表示されている事" do
            login(user_with_image)
            visit post_path(post)
            expect(page).to have_content post.user.name
            expect(page).to have_selector "img[src$='test.jpg']"  
          end
        end
      end
    end

    describe "遷移テスト" do
      it "編集するをクリックすると投稿編集ページに遷移する事" do
        login(user)
        visit post_path(post)
        click_on "編集する"
        expect(current_path).to eq edit_post_path(post)
      end
    end
  end

  describe "ユーザー編集ページ" do
    before do
      login(user)
      visit edit_post_path(post)
    end
    
    describe "表示テスト" do
      it "投稿ボタンが「投稿を変更する」という表記になっている事" do
        expect(page).to have_button "投稿を変更する"
      end
    end

    describe "遷移テスト" do
      let(:another_user_post) { create(:post) }

      context "フォーム入力値が正常" do
        it "投稿編集に成功する事" do
          fill_in "post_title", with: "edit_test_title"
          fill_in "post_content", with: "edit_test_content"
          fill_in "post_extra_fee", with: 1
          choose "post_change_ちょい変"
          attach_file "post[image]", "#{Rails.root}/spec/factories/post.test.png"
          click_on "投稿を変更する"
          expect(current_path).to eq post_path(post)
          expect(page).to have_content "投稿を更新しました"
        end
      end

      context "タイトルが未入力" do
        it "投稿編集に失敗する事" do
          fill_in "post_title", with: nil
          fill_in "post_content", with: "edit_test_content"
          fill_in "post_extra_fee", with: 1
          choose "post_change_ちょい変"
          attach_file "post[image]", "#{Rails.root}/spec/factories/post.test.png"
          click_on "投稿を変更する"
          expect(current_path).to eq "/posts/#{post.id}"
          expect(page).to have_content "投稿の編集に失敗しました"
          expect(page).to have_content "タイトルを入力してください"
        end
      end

      it "投稿作成者以外が編集しようとするとトップページに戻される事" do
        visit edit_post_path(another_user_post)
        expect(current_path).to eq root_path
        expect(page).to have_content "他のユーザーの投稿は編集できません"
      end
    end
  end
end
