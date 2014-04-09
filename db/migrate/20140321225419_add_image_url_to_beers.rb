class AddImageUrlToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :image_url, :string
  end
end
