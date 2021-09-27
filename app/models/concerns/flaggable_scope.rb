# app/models/concerns/flaggable_scope.rb
module FlaggableScope
  extend ActiveSupport::Concern

  included do
    scope :is_flagged, ->(user_id) { joins(:flags).where("#{table_name}.user_id != ? and (flags.admin_resolved is False and flags.user_resolved is False)", user_id) }
    scope :not_flagged, ->(user_id) { where.not(id: is_flagged(user_id)) }

    def flagged?
      unresolved_flags.any?
    end

    def last_unresolved_flag
      unresolved_flags.order(created_at: :desc).first
    end

    def unresolved_flags
      flags.where(user_resolved: false).or(flags.where(admin_resolved: false))
    end
  end
end
