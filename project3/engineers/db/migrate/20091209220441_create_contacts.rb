class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.String :email
      t.String :type
      t.Integer :engineer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
