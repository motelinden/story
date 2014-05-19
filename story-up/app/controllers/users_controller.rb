class UsersController < ApplicationController
	before_action :authenticate_user!

	def show 
		@user=User.find(params[:id])
		  respond_to do |format|
        format.html { @user }
       # format.json { render action: 'show', location: @node}
        format.json { render json: @user, status: :ok}
    end
	end

	def stories
		@stories = Story.all
	end

	def readings
		time = 365.days.ago
		p "#{time}"
		@stories = Story.joins(:user_actions).where("user_actions.user_id = ? AND user_actions.action_type = ? 
			AND user_actions.created_at > ? AND user_actions.node_id not null AND user_actions.story_id not null", current_user.id, 2, time).distinct("stories.id")
		@nodes = Node.joins(:user_actions).where("user_actions.user_id = ? AND user_actions.action_type = ? 	
		 AND user_actions.created_at > ?  AND user_actions.node_id not null   AND user_actions.story_id not null", current_user.id, 2, time).order(" nodes.level ").distinct("nodes.id")
		 
	 
	end
end
