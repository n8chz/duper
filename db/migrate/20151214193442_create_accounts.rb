class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.text :name
      t.text :number
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
