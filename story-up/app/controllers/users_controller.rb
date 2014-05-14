class UsersController < ApplicationController
	before_action :authenticate_user!

	def show 
	end

	def stories
		@stories = Story.all
	end
end
