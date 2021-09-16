# app/models/like.rb
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :project

  after_create :increment_count
  after_destroy :decrement_count

  validates :user_id, uniqueness: { scope: :project_id }

  scope :tooltip, -> { includes(:user).order(created_at: :desc).limit(20).map { |like| like.user.full_name.to_s }.join("\n") }

  def increment_count
    project.update!(like_count: project.like_count + 1)
    user.update!(likes_given: user.likes_given + 1)
  end

  def decrement_count
    project.update!(like_count: project.like_count - 1)
    user.update!(likes_given: user.likes_given - 1)
  end
end
