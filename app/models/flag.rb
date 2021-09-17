# app/models/flag.rb
class Flag < ApplicationRecord
  belongs_to :user
  belongs_to :flaggable, polymorphic: true

  validates_presence_of :user_id, :reason, :flaggable

  scope :most_recent, -> { order(created_at: :desc) }
end
