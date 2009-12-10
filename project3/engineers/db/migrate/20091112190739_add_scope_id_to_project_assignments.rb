class AddScopeIdToProjectAssignments < ActiveRecord::Migration
  def self.up
    add_column :project_assignments, :scope_id, :integer
  end

  def self.down
    remove_column :project_assignments, :scope_id
  end
end
