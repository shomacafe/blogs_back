class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: {maximum: 50, message: "タイトルは50文字以内で入力してください" }
  validates :body, presence: true, length: {maximum: 5000, message: "本文は5000文字以内で入力してください"}
end
