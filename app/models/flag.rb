# app/models/flag.rb
class Flag < ApplicationRecord
  belongs_to :user
  belongs_to :flaggable, polymorphic: true

  before_save :update_flagged

  validates_presence_of :user_id, :reason, :flaggable

  scope :most_recent, -> { order(created_at: :desc) }

  private

  def update_flagged
    flaggable.update!(flagged: admin_resolved && user_resolved)
  end
end
