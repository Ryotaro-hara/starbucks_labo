require 'rails_helper'

RSpec.describe "Posts", type: :request do

  describe "GET #index" do

    before do
      get root_path
    end

    it "レスポンスが正しく返ってくる事" do
      expect(response).to have_http_status(200)
    end
  end

end
