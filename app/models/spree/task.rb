module Spree
  class Task < Spree::Base
    self.table_name = "tasks"
    belongs_to :activity
    has_many :efforts
    has_many :users, through: :efforts

    self.whitelisted_ransackable_associations = %w[efforts activity]
    self.whitelisted_ransackable_attributes = %w[activity_id]
    
    def activity_task
      "#{activity.name if activity} > #{name}"
    end
  end
end