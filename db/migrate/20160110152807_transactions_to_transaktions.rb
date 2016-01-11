class TransactionsToTransaktions < ActiveRecord::Migration

  def self.up
    rename_table :transactions, :transaktions
  end

  def self.down
    rename_table :transaktions, :transactions
  end

end
