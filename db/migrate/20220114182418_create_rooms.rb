class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :description
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
