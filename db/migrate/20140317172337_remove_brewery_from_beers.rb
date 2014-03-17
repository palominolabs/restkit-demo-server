class RemoveBreweryFromBeers < ActiveRecord::Migration
  def change
    remove_column :beers, :brewery, :string
  end
end
