json.array!(@units) do |unit|
  json.extract! unit, :id, :unit, :factor, :m, :kg, :s, :a, :k, :cd, :mol
  json.url unit_url(unit, format: :json)
end
