class UsersController < ApplicationController
	before_action :authenticate_user!

	def show 
	end

	def stories
		@stories = Story.where("stories.user_id = ?", current_user.id)
		@nodes 	 = Node.where("nodes.user_id  = ?", current_user.id)
	end
end
