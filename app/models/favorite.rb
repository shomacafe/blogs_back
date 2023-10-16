class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :post_id, scope: :user_id

  def self.exists?(user_id, post_id)
    where(user_id: user_id, post_id: post_id).exists?
  end
end
