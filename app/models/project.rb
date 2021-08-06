# app/models/project.rb
class Project < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes

  validates_presence_of :user_id, :name, :summary
  validates :name, presence: true
  validates :summary, length: { maximum: 240 }
end
