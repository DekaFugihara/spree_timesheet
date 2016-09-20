module Spree
  class TimeSheet < ActiveRecord::Base
    self.table_name = "time_sheets"
    belongs_to :user
    
    def display(attribute)
      self.send(attribute).strftime("%H:%M") unless self.send(attribute).nil?
    end
    
    def total
      if exit_time && entrance_time && lunch_return_time && lunch_exit_time
        (exit_time - entrance_time) - (lunch_return_time - lunch_exit_time)
      end
    end
    
    def display_total
      if total
        difference = total
        seconds    = difference % 60
        difference = (difference - seconds) / 60
        minutes    = ( difference % 60)
        difference = (difference - minutes) / 60
        hours      = (difference % 24)
        return "#{hours.to_i}h#{minutes.to_i}m"
      end
    end
    
  end
end