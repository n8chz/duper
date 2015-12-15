class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :transaction, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true
      t.integer :price
      t.float :qty
      t.boolean :is_debit
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
