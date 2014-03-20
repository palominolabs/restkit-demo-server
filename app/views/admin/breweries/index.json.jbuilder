json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name
  json.url brewery_url(brewery, format: :json)
end
