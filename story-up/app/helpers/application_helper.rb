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
	
	def node_comments(node)
	 
		Comment.where("comments.node_id = ?", node.id).count
		 
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
	
	def node_read_time(userId,nodeId)
		 
		@action=UserAction.where("user_actions.node_id = ? AND user_actions.user_id=?", nodeId,userId).order("user_actions.updated_at desc").first
		#@action=Node.where("nodes.id = ?  ", 0).first
		if(@action!=  nil)
			@read_time=@action.updated_at.strftime("%Y-%m-%d [%H:%M]")
		else
	 		@read_time=""
	 	end
	end
end
