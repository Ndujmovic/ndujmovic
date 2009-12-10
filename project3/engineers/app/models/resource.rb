class Resource < ActiveRecord::Base
   belongs_to :engineer
   has_attached_file :f
end
