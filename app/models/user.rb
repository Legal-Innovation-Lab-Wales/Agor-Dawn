class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable #,:confirmable

  has_many :comments
  has_many :projects
  has_many :likes

  scope :admins, -> { where(admin: true) }
  scope :non_admins, -> { where(admin: false) }
end
