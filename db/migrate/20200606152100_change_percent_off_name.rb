class ChangePercentOffName < ActiveRecord::Migration[5.1]
  def change
      rename_column :discounts, :percent_off, :percent
  end
end
