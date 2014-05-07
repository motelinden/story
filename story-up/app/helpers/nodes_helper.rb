module NodesHelper
	def to_prev(node)
		node.parent
	end

	def to_next(node)
		Node.includes(:statistic).where("nodes.parent_id = ?", node.id).order("statistics.rating, statistics.reading, nodes.created_at desc").first
	end

	def prev?(node)
		node.parent_id.present?
	end

	def next?(node)
		count = Node.where("nodes.parent_id = ?", node.id).count
		p "#{count}-------------------------------"
		count > 0
	end
end
