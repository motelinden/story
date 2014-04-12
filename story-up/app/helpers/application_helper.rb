module ApplicationHelper

	def levels(story)
		max_level = story.nodes.maximum("nodes.level")
		if max_level.present?
			max_level
		else
			0
		end
	end

	def nodes_at_level(story, level)
		story.nodes.includes(:statistic).where("nodes.level = ?", level).order("statistics.rating, statistics.reading, nodes.created_at desc")
	end

end
