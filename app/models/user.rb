# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable
  after_save :set_default_avatar # Cannot occur after_create because of seed
  after_update :purge_unattached_avatars, if: -> { avatar.changed? }
  after_create :mail_admins, unless: -> { approved? }

  has_many :comments, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :avatar, dependent: :detach

  scope :admins, -> { where(admin: true) }
  scope :non_admins, -> { where(admin: false) }
  scope :unauthenticated, -> { where(approved: false) }
  scope :authenticated, -> { where(approved: true) }

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

  private

  def set_default_avatar
    return if avatar.attached?

    avatar.attach(ActiveStorage::Blob.where(default_avatar: true).order('RANDOM()').first)
  end

  def purge_unattached_avatars
    ActiveStorage::Blob.unattached.where(default_avatar: false).each(&:purge_later)
  end

  def mail_admins
    User.admins.each { |admin| AdminMailer.new_user_signup(self, admin).deliver_now }
  end
end
