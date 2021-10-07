# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :replaced_by, class_name: 'Comment', optional: true, foreign_key: 'replaced_by_id'
  belongs_to :replacing, class_name: 'Comment', optional: true, foreign_key: 'replacing_id'

  after_create :increment_count, unless: -> { replacing.present? }
  after_destroy :decrement_count, unless: -> { replacing.present? }

  validates :comment_text, presence: true

  scope :originals, -> { where(replacing: nil).order(created_at: :asc) }

  def increment_count
    project.update!(comment_count: project.comment_count + 1)
    user.update!(comments_posted: user.comments_posted + 1)
  end

  def decrement_count
    project.update!(comment_count: project.comment_count - 1)
    user.update!(comments_posted: user.comments_posted - 1)
  end

  def owner?(user)
    self.user == user
  end

  def newest
    return self unless replaced_by.present?

    replaced_by.newest
  end
end
