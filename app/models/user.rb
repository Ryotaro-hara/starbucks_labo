class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX, message: 'が有効ではありません' },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, on: :update
  validates :password, confirmation: true, on: :update

  mount_uploader :image, ImageUploader
end
