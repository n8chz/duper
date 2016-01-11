class EntriesTransaktionId < ActiveRecord::Migration

  def self.up
    rename_column :entries, :transaction_id, :transaktion_id
  end

  def self.down
    rename_column :entries, :transaktion_id, :transaction_id
  end

end
