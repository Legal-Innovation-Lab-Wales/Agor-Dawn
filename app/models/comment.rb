# app/models/comment.rb
class Comment < ApplicationRecord
  default_scope { order('created_at ASC') }
  belongs_to :user
  belongs_to :project

  after_create :increment_count
  after_destroy :decrement_count

  validates :comment_text, presence: true

  def increment_count
    project.update!(comment_count: project.comment_count + 1)
    user.update!(comments_posted: user.comments_posted + 1)
  end

  def decrement_count
    project.update!(comment_count: project.comment_count - 1)
    user.update!(comments_posted: user.comments_posted - 1)
  end
end
