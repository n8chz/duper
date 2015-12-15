json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :date, :entity_id, :is_void
  json.url transaction_url(transaction, format: :json)
end
