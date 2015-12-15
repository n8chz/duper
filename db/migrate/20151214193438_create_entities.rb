class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.text :name
      t.integer :no
      t.float :frac
      t.text :unit
      t.text :street
      t.text :box
      t.text :city
      t.text :polsub
      t.text :postal
      t.text :nation
      t.text :phone
      t.text :email
      t.text :url

      t.timestamps null: false
    end
  end
end
