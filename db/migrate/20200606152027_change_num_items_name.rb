class ChangeNumItemsName < ActiveRecord::Migration[5.1]
  def change
    rename_column :discounts, :num_items, :quantity
  end
end
