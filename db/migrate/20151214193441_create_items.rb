class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :barcode
      t.text :brand
      t.text :gendesc
      t.float :size
      t.references :unit, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
