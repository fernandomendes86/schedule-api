class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.string :subject
      t.datetime :start_at
      t.datetime :end_at
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
