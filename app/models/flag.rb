# app/models/flag.rb
class Flag < ApplicationRecord
  belongs_to :flaggable, polymorphic: true

  validates_presence_of :user_id, :reason, :flaggable

  enum status: {
    under_review: 0,
    resolved: 1,
    archived: 2
  }
end
