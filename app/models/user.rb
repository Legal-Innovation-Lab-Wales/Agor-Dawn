# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable
  after_save :set_default_avatar

  has_many :comments
  has_many :projects
  has_many :likes
  has_one_attached :avatar

  scope :admins, -> { where(admin: true) }
  scope :non_admins, -> { where(admin: false) }

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def set_default_avatar
    return if avatar.attached?

    avatar.attach(ActiveStorage::Blob.where(default_avatar: true).order('RANDOM()').first)
  end
end
