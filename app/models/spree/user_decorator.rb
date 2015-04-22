Spree::User.class_eval do
  has_many :tasks, through: :efforts
  has_many :time_sheets
  has_many :efforts
end