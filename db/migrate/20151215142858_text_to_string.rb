class TextToString < ActiveRecord::Migration
  def change
    change_column :entities, :name, :string
    change_column :entities, :unit, :string
    change_column :entities, :street, :string
    change_column :entities, :box, :string
    change_column :entities, :city, :string
    change_column :entities, :polsub, :string
    change_column :entities, :postal, :string
    change_column :entities, :nation, :string
    change_column :entities, :phone, :string
    change_column :entities, :email, :string
    change_column :units, :unit, :string
    change_column :items, :barcode, :string
    change_column :items, :brand, :string
    change_column :items, :gendesc, :string
    change_column :accounts, :name, :string
    change_column :accounts, :number, :string
  end
end
