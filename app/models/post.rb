class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  enum change: { ちょい変: 1, 激変: 2 }
  
  with_options presence: true do
    validates :title
    validates :content
    validates :drink_type
    validates :extra_fee
    validates :change
    validates :image
  end

  def favorite?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  mount_uploader :image, ImageUploader
end
