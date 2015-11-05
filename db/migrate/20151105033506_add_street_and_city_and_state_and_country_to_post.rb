class AddStreetAndCityAndStateAndCountryToPost < ActiveRecord::Migration
  def change
    add_column :posts, :street, :string
    add_column :posts, :city, :string
    add_column :posts, :state, :string
    add_column :posts, :country, :string
  end
end
