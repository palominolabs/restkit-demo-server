class AddInventoryToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :inventory, :integer
  end
end
