class CreateEfforts < ActiveRecord::Migration
  def change
    create_table :efforts do |t|
      t.integer :user_id
      t.integer :task_id
      t.integer :object_id
      t.string :object_type
      t.string :description
      t.float :amount
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end
