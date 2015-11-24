json.array!(@autobids) do |autobid|
  json.extract! autobid, :id
  json.url autobid_url(autobid, format: :json)
end
