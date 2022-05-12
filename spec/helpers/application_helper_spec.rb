require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'タイトルが動的に表示される事' do
    it 'ページタイトルを持たない時Starbucks laboと表示される事' do
      expect(full_title("")).to eq "Starbucks labo"
    end

    it 'ページタイトルを持つ時page_title - Starbucks laboと表示される事' do
      expect(full_title("page_title")).to eq "page_title - Starbucks labo"
    end

    it 'nilが渡ってきた時Starbucks laboと表示される事' do
      expect(full_title(nil)).to eq "Starbucks labo"
    end
  end
end
