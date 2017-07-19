class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.references :user
      t.references :listing

      t.timestamps
    end
  end
end
