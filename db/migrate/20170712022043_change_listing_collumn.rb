class ChangeListingCollumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :listings, :image
    add_column :listings, :image, :json
  end
end
