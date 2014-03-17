class AddBeersCountToBreweries < ActiveRecord::Migration
  def change
    add_column :breweries, :beers_count, :integer
  end
end
