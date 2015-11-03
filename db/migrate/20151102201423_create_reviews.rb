class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :reviewer
      t.belongs_to :lender
      t.belongs_to :exchange
      t.float :rating	
      t.text :review

      t.timestamps null: false
    end
  end
end
