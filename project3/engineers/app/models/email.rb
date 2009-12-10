class Email < ActiveRecord::Base
   scope :has_one
   belongs_to :engineer
end
