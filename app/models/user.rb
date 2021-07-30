class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable #,:confirmable

  has_many :comments
  has_many :projects
end
