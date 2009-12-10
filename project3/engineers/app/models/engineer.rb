
class Engineer < ActiveRecord::Base
  has_many :project_assignments, :dependent => :destroy
  has_many :projects, :through => :assignments
  has_many :emails, :dependent => :destroy
  belongs_to :skill_level
  
  accepts_nested_attributes_for :project_assignments, :allow_destroy => true

  acts_as_taggable
  acts_as_solr :fields => [:fname, :lname]

  validates_presence_of :skill_level_id

  has_many :resources, :dependent => :destroy 

  def get_resume
    @resume_text = "No resume to display."
    if self.resources then
    self.resources.each do |r|
      if !r.f.path.nil? and r.f_content_type == "text/plain" then
      @resume_text = File.read(r.f.path)
      end
    end
    end

    @resume_text
    end

    end
