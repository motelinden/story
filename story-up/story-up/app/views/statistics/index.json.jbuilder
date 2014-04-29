json.array!(@statistics) do |statistic|
  json.extract! statistic, :id, :story_id, :node_id, :reading, :rating
  json.url statistic_url(statistic, format: :json)
end
