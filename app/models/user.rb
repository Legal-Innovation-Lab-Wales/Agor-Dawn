# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  has_many :comments
  has_many :projects
  has_many :likes
  has_one_attached :avatar

  scope :admins, -> { where(admin: true) }
  scope :non_admins, -> { where(admin: false) }

  def full_name
    "#{first_name} #{last_name}"
  end
end
