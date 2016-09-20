module Spree
  class Task < ActiveRecord::Base
    self.table_name = "tasks"
    belongs_to :activity
    has_many :efforts
    has_many :users, through: :efforts
    
    def activity_task
      "#{activity.name if activity} > #{name}"
    end
  end
end