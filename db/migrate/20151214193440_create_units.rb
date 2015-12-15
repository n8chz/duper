class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.text :unit
      t.float :factor
      t.integer :m
      t.integer :kg
      t.integer :s
      t.integer :a
      t.integer :k
      t.integer :cd
      t.integer :mol

      t.timestamps null: false
    end
  end
end
