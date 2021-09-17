# app/models/project.rb
class Project < ApplicationRecord
  include FlaggableScope

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :flags, as: :flaggable

  validates_presence_of :user_id, :name, :summary, :like_count, :comment_count
  validates :name, presence: true
  validates :summary, length: { maximum: 240 }

  scope :search, lambda { |query|
    joins(:user).where('lower(name) similar to lower(:query) ' \
                       'or lower(summary) similar to lower(:query) ' \
                       'or lower(users.first_name) similar to lower(:query) ' \
                       'or lower(users.last_name) similar to lower(:query)',
                       { query: "%#{query.split.join('%|%')}%" })
  }
  scope :is_public, -> { where(public: true) }
  scope :most_recent, -> { order(created_at: :desc) }
  scope :most_popular, -> { order(like_count: :desc) }
  scope :most_discussed, -> { order(comment_count: :desc) }

  has_rich_text :content
end
