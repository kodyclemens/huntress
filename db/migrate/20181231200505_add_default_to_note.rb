class AddDefaultToNote < ActiveRecord::Migration
  def change
    change_column :jobs, :note, :text, default: 'Edit to add your own note.'
  end
end
