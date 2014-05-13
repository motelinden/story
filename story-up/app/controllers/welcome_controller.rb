class WelcomeController < ApplicationController
 before_action :authenticate_user!, except: [ :index,:show]
	def index
	p '--------index begin------------'
	
	p params[:openid]
	p params[:openkey]
	p params[:pf]
 	p params[:resource_name]
 	p params[:resource]
 
	p '------------index enf------'
	
	params[:id]
		@stories = Story.all
	end
end
