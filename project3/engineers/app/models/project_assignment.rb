class ProjectAssignment < ActiveRecord::Base
   has_one :scope
   belongs_to :engineer
   belongs_to :project
end
