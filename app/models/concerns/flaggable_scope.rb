# app/models/concerns/flaggable_scope.rb
module FlaggableScope
  extend ActiveSupport::Concern

  included do
    scope :is_flagged, ->(user_id) { joins(:flags).where("#{table_name}.user_id != ? and (flags.admin_resolved is False and flags.user_resolved is False)", user_id) }
    scope :not_flagged, ->(user_id) { where.not(id: is_flagged(user_id)) }

    def flagged?
      flags.where(user_resolved: false).or(flags.where(admin_resolved: false)).any?
    end
  end
end
