class Engineer < ActiveRecord::Base
  has_many :project_assignments, :dependent => :destroy
  has_many :projects, :through => :assignments
  belongs_to :skill_level
  
  accepts_nested_attributes_for :project_assignments, :allow_destroy => true

  acts_as_taggable
  validates_presence_of :skill_level_id
  
end
