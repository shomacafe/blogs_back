class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :body, presence: true, length: {maximum: 500, message: "コメントは500文字以内で入力してください"}
end
