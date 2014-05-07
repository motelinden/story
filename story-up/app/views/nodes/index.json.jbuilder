json.array!(@nodes) do |node|
  json.extract! node, :id, :story_id, :parent_id, :user_id, :level, :path, :content
  json.url node_url(node, format: :json)
end
