class AddStatusToExchanges < ActiveRecord::Migration
  def change
    add_column :exchanges, :status, :integer
  end
end
