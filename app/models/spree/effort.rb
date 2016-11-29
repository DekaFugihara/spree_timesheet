module Spree
  class Effort < ActiveRecord::Base
    self.table_name = "efforts"
    belongs_to :user
    belongs_to :task
    before_save :calculate_amount
    belongs_to :object, polymorphic: true

    def display(attribute)
      self.send(attribute).strftime("%d/%m-%H:%M") unless self.send(attribute).nil?
    end

    def display_amount
      if amount
        difference = amount
        seconds    = difference % 60
        difference = (difference - seconds) / 60
        minutes    = ( difference % 60)
        difference = (difference - minutes) / 60
        hours      =  (difference % 24)
        return "#{hours.to_i}h:#{minutes.to_i}m"
      end
    end

    def object_name
      case object_type
      when "Spree::Plp" then "PLP"
      when "Spree::StockBox" then "Caixa"
      else "Sacola"
      end
    end

    def object_title
      if object_type == "Spree::Plp"
        "##{object_id}"
      else
        "##{object.number}"
      end
    end
    
    private
    
    def calculate_amount
      self.amount = completed_at - started_at if completed_at && started_at
    end
    
  end
end