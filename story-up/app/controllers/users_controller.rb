class UsersController < ApplicationController
	before_action :authenticate_user!

	def show 
	end

	def stories
		@stories = Story.all
	end

	def readings
		time = 3.days.ago
		p "#{time}"
		@stories = Story.joins(:user_actions).where("user_actions.user_id = ? AND user_actions.action_type = ? 
			AND user_actions.created_at > ?", current_user.id, 2, time).distinct("stories.id")
		@nodes = Node.joins(:user_actions).where("user_actions.user_id = ? AND user_actions.action_type = ? 
			AND user_actions.created_at > ?", current_user.id, 2, time).distinct("nodes.id")
	end
end
