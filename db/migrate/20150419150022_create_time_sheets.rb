class CreateTimeSheets < ActiveRecord::Migration
  def change
    create_table :time_sheets do |t|
      t.integer :user_id
      t.date :date
      t.time :entrance_time
      t.time :exit_time
      t.time :lunch_exit_time
      t.time :lunch_return_time
      t.text :obs

      t.timestamps
    end
  end
end
