class Project < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  def liked?(user)
    #!!self.likes.find{|like| like.user_id == user.id}
    likes.find_by(user_id: user.id).present?
  end
end
