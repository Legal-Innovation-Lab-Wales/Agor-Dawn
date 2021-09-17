# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable
  after_save :set_default_avatar
  after_update :purge_unattached_avatars, if: -> { avatar.changed? }

  has_many :comments
  has_many :projects
  has_many :likes
  has_one_attached :avatar, dependent: :detach

  scope :admins, -> { where(admin: true) }
  scope :non_admins, -> { where(admin: false) }

  validates_presence_of :likes_given, :comments_posted
  validates :bio, length: { maximum: 240 }

  def full_name
    "#{first_name} #{last_name}"
  end

  def likes_received
    projects.map(&:like_count).sum
  end

  def comments_received
    projects.map(&:comment_count).sum
  end

  def flagged_comments
    comments.filter(&:flagged?)
  end

  def flagged_projects
    projects.filter(&:flagged?)
  end

  private

  def set_default_avatar
    return if avatar.attached?

    avatar.attach(ActiveStorage::Blob.where(default_avatar: true).order('RANDOM()').first)
  end

  def purge_unattached_avatars
    ActiveStorage::Blob.unattached.where(default_avatar: false).each(&:purge_later)
  end
end
