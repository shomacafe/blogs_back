# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  mount_uploader :image, ImageUploader

  before_validation :set_default_profile

  def set_default_profile
    self.profile ||= "#{self.name}です。よろしくお願いします。"
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true, length: {maximum: 30 }
  validates :profile, length: {maximum: 300 }
end
