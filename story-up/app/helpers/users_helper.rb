module UsersHelper
	def my_stories(story)
		nodes = story.nodes.includes(:statistic).where("nodes.user_id = ?", current_user.id).order("statistics.follows, statistics.rating, statistics.reading, nodes.created_at asc")
		nodes
	end
end
