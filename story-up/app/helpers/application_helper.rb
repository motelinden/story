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
		#story.nodes.includes(:statistic).where("nodes.level = ?", level).order("statistics.rating, statistics.reading, nodes.created_at desc")
		story.nodes.includes(:statistic).where("nodes.level = ?", 
			level).order("nodes.created_at desc")
	end


	def story_followers(story)
		story.nodes.count
	end

	def node_followers(node)
		Node.where("nodes.parent_id = ?", node.id).count
	end

	def short_text(max, text)
		if text.length > max
			short_version = text[0..max] + "..."
		else
			offset = max - text.length
			offset.times do |t|
				text += " "
			end
			p "#{text}"
			text
		end
	end

end
