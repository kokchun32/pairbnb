class AddDateToReservation < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :check_in, :date
    add_column :reservations, :check_out, :date
  end
end
