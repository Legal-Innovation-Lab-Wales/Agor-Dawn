class Like < ApplicationRecord
  belongs_to :user
  belongs_to :project

  after_create :increment_count
  after_destroy :decrement_count

  validates :user_id, uniqueness: { scope: :project_id }

  def increment_count
    project.update!(like_count: project.like_count + 1)
  end

  def decrement_count
    project.update!(like_count: project.like_count - 1)
  end
end
