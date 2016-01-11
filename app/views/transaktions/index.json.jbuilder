json.array!(@transaktions) do |transaktion|
  json.extract! transaktion, :id, :date, :entity_id, :is_void
  json.url transaktion_url(transaktion, format: :json)
end
