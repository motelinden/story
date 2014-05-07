class UsersController < ApplicationController
#	before_action :authenticate_user!

	def show 
		 @user  = User.find(params[:id])

    # no matter or what, show the story
    respond_to do |format|
        format.html { @user }
       # format.json { render action: 'show', location: @node}
        format.json { render json: @user, status: :ok}
    end
	end

	def stories
		@stories = Story.where("stories.user_id = ?", current_user.id)
		@nodes 	 = Node.where("nodes.user_id  = ?", current_user.id)
	end
end
