json.array!(@entities) do |entity|
  json.extract! entity, :id, :name, :no, :frac, :unit, :street, :box, :city, :polsub, :postal, :nation, :phone, :email, :url
  json.url entity_url(entity, format: :json)
end
