class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company, default: ''
      t.string :location, default: ''
      t.string :description, default: ''
      t.boolean :applied, default: false
      t.integer :user_id
    end
  end
end
