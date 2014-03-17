class AddBreweryRefToBeers < ActiveRecord::Migration
  def change
    add_reference :beers, :brewery, index: true
  end
end
