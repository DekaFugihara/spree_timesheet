module Spree
  class Activity < ActiveRecord::Base
    self.table_name = "activities"
    attr_accessible :name, :tasks_attributes
    has_many :tasks, dependent: :destroy
    accepts_nested_attributes_for :tasks, allow_destroy: true
  end
end
