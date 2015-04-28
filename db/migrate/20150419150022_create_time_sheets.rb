class CreateTimeSheets < ActiveRecord::Migration
  def change
    create_table :time_sheets do |t|
      t.integer :user_id
      t.date :date
      t.datetime :entrance_time
      t.datetime :exit_time
      t.datetime :lunch_exit_time
      t.datetime :lunch_return_time
      t.text :obs

      t.timestamps
    end
  end
end
