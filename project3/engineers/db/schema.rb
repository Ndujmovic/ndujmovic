# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091210150313) do

  create_table "bdrb_job_queues", :force => true do |t|
    t.text     "args"
    t.string   "worker_name"
    t.string   "worker_method"
    t.string   "job_key"
    t.integer  "taken"
    t.integer  "finished"
    t.integer  "timeout"
    t.integer  "priority"
    t.datetime "submitted_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "archived_at"
    t.string   "tag"
    t.string   "submitter_info"
    t.string   "runner_info"
    t.string   "worker_key"
    t.datetime "scheduled_at"
  end

  create_table "contacts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", :force => true do |t|
    t.string   "address"
    t.string   "addresstype"
    t.integer  "engineer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "engineers", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.text     "resume"
    t.integer  "skill_level_id"
    t.integer  "years_of_experience"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_assignments", :force => true do |t|
    t.integer  "project_id"
    t.integer  "engineer_id"
    t.date     "sdate"
    t.date     "edate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_scope_id"
    t.integer  "scope_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  create_table "resources", :force => true do |t|
    t.integer  "engineer_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "f_file_name"
    t.string   "f_content_type"
    t.integer  "f_file_size"
    t.datetime "f_updated_at"
  end

  create_table "scopes", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skill_levels", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tests", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

    create_table :delayed_jobs, :force => true do |table|
      table.integer  :priority, :default => 0
        table.integer  :attempts, :default => 0
          table.text     :handler
            table.string   :last_error
              table.datetime :run_at
                table.datetime :locked_at
                  table.datetime :failed_at
                    table.string   :locked_by
                      table.timestamps
                        end


end
