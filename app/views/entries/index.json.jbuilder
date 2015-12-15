json.array!(@entries) do |entry|
  json.extract! entry, :id, :transaction_id, :item_id, :price, :qty, :is_debit, :account_id
  json.url entry_url(entry, format: :json)
end
