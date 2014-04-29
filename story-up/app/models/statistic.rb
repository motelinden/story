class Statistic < ActiveRecord::Base

	belongs_to :node
	belongs_to :story

	def self.create_or_update_story_statistic(story, action)
	    
	    @statistic = Statistic.where("statistics.story_id = ? And statistics.node_id is null", story.id).first

	    if @statistic.nil?
	      	@statistic = Statistic.new
	      	@statistic.story_id = story.id
	      	@statistic.reading = 1
	      	@statistic.save
	    else
	    	update_statistic(action)
	    end

	end

	def self.create_or_update_node_statistic(story, node, action)
		
		@statistic = Statistic.where("statistics.story_id = ? And statistics.node_id = ?", story.id, node.id).first

	    if @statistic.nil?
		    @statistic = Statistic.new
		    @statistic.story_id = story.id
		    @statistic.node_id = node.id
		    @statistic.reading = 1
		    @statistic.save
	    else
	      	update_statistic(action)
	    end
	    
	end

	private

	def self.update_statistic(action)

		if action.action_type == 0
	    	@statistic.update(reading: @statistic.reading + 1, rating: @statistic.rating + 1)
	    elsif action.action_type == 2
	    	@statistic.update(reading: @statistic.reading + 1)
	    elsif action.action_type == 4
	    	@statistic.update(reading: @statistic.reading + 1, comments: @statistic.comments + 1)
	    else
	    	@statistic.update(reading: @statistic.reading + 1, follows: @statistic.follows + 1)
	    end
	end

end
