class Project < ApplicationRecord
  belongs_to :user

  def liked?(user)
    #!!self.likes.find{|like| like.user_id == user.id}
    likes.find_by(user_id: user.id).present?
  end

  has_many :comments, dependent: :destroy
  has_many :likes

  validates_presence_of :user_id, :name, :summary
  validates :name, presence: true
  validates :summary, length: { maximum: 240 }
end
