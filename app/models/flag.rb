# app/models/flag.rb
class Flag < ApplicationRecord
  belongs_to :flagged_by, class_name: 'User', foreign_key: 'flagged_by_id'
  belongs_to :flaggable, polymorphic: true

  after_create :mail_user
  before_update :mail_admin, if: -> { !user_resolved_was && user_resolved }
  before_update :mail_flag_resolved, if: -> { !admin_resolved_was && admin_resolved }

  validates_presence_of :flagged_by_id, :reason, :flaggable

  scope :most_recent, -> { order(created_at: :desc) }

  private

  def mail_user
    FlagMailer.new_flag(flaggable.user, reason, flaggable_type.downcase, flaggable[:project_id] || flaggable.id)
  end

  def mail_admin
    # Send mail to admin that user thinks they've solved it...
  end

  def mail_flag_resolved
    # Send mail to user that the flag is considered resolved...
  end
end
