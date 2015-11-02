class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      # t.references :lender, index: true, foreign_key: true
      # t.references :borrower, index: true, foreign_key: true
      t.belongs_to :lender
      t.belongs_to :borrower
      # t.references :post_id, index: true, foreign_key: true
      t.belongs_to :post	
      t.int :status
      t.timestamps null: false
    end
  end
end
