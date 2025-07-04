class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.belongs_to :assigned_user, index: true, foreign_key: { to_table: "users" }
      t.date :due_date
      t.integer :status
      t.integer :progress

      t.timestamps
    end
  end
end
