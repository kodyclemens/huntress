class AddTimestampToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :created_on, :timestamp
  end
end
