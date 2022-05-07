class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  enum change: { ちょい変: 1, 激変: 2 }
  
  with_options presence: true do
    validates :title
    validates :content
    validates :extra_fee
    validates :change
    validates :image
  end
  
  mount_uploader :image, ImageUploader
end
