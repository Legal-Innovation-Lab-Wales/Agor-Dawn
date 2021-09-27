# app/models/flag.rb
class Flag < ApplicationRecord
  belongs_to :flagged_by, class_name: 'User', foreign_key: 'flagged_by_id'
  belongs_to :flaggable, polymorphic: true

  after_create :mail_user
  # TODO: Add after_update (?) that appends to the reason and send mailer to admin/user depending on which resolved field flipped.

  validates_presence_of :flagged_by_id, :reason, :flaggable

  scope :most_recent, -> { order(created_at: :desc) }

  private

  def mail_user
    FlagMailer.new_flag(flaggable.user, reason, flaggable_type.downcase, flaggable[:project_id] || flaggable.id)
  end
end
