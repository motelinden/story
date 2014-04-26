class UserAction < ActiveRecord::Base
	belongs_to :user
	belongs_to :story

	def self.record_action(story, node, user, action_type)
		@user_action = UserAction.new
	    @user_action.story = story

	    if not node.nil?
	    	@user_action.node_id = node.id
	    end

	    @user_action.user = user
	    @user_action.action_type = action_type
	    @user_action.save

	    @user_action
	end
end
