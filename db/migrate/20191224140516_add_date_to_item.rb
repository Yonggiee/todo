class AddDateToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :expiryDate, :date
  end
end
