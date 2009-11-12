class Project < ActiveRecord::Base
 # has_many :project_assignments, :dependent => :destroy
 # has_many :engineers, :through => :project_assignments

  validates_uniqueness_of :name
  has_many :project_assignments, :dependent => :destroy

  acts_as_taggable
end
