class AddNameToDiscounts < ActiveRecord::Migration[5.1]
  def change
    add_column :discounts, :name, :string
  end
end
