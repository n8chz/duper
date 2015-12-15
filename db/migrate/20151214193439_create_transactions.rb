class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.datetime :date
      t.references :entity, index: true, foreign_key: true
      t.boolean :is_void

      t.timestamps null: false
    end
  end
end
