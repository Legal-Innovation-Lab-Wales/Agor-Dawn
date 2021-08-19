class Comment < ApplicationRecord
  default_scope { order('created_at DESC') }
  belongs_to :user
  belongs_to :project
  validates :comment_text, presence: true
end
