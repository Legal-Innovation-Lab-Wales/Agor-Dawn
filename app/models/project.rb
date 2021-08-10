class Project < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates_presence_of :user_id, :name, :summary
  validates :name, presence: true
  validates :summary, length: { maximum: 240 }

  has_rich_text :content
end
