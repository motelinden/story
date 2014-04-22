json.array!(@user_actions) do |user_action|
  json.extract! user_action, :id, :story_id, :node_id, :user_id, :action_type
  json.url user_action_url(user_action, format: :json)
end
