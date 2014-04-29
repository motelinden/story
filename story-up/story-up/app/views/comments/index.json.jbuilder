json.array!(@comments) do |comment|
  json.extract! comment, :id, :user_id, :story_id, :node_id, :parent_id, :content
  json.url comment_url(comment, format: :json)
end
