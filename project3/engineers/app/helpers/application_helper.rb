# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper

  def setup_engineer(engineer)
    returning(engineer) do |e|
       e.project_assignments.build if e.project_assignments.empty?
    end
  end

  def image? (file_type) 
    %w[application/pdf application/jpg 
    application/png application/gif 
    application/tiff].include?(file_type) 
  end

  def text? (file_type)
    %w[text/plain].include?(file_type)
  end

end
