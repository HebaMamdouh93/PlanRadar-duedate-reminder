class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :due_date_reminders_enabled, default: false
      t.integer :reminder_interval
      t.time :reminder_time
      t.string :time_zone

      t.timestamps
    end
  end
end
