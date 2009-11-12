class CreateEngineers < ActiveRecord::Migration
  def self.up
    create_table :engineers do |t|
      t.string :fname
      t.string :lname
      t.text :resume
      t.integer :skill_level_id
      t.integer :years_of_experience

      t.timestamps
    end
  end

  def self.down
    drop_table :engineers
  end
end
