class Project < ApplicationRecord
  belongs_to :user

  has_many :comments

  validates_presence_of :user_id, :name, :summary
  validates :name, presence: true
  validates :summary, length: { maximum: 240 }
end
