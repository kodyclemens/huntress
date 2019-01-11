class AddNotesToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :note, :text, default: ''
  end
end
