class WelcomeController < ApplicationController
 before_action :authenticate_user!, except: [ :index,:show]
	def index
 		if !params[:openid].nil?
		 		if !user_signed_in? 
		 			@user = User.find_by(openid: params[:openid])
				  if @user.nil?
				  	# user automatic registered
				  		@qqUser=get_info(params[:openid],params[:openkey],params[:pf])
				  	username=qqUser.nickname
						@user= User.new( :username=>username, :openid=>params[:openid],:email=>"")
						@user.save
					end
			   # automatic   login
					sign_in @user   
			 		session[:openid]=params[:openid]
				  session[:openkey]=params[:openkey]
				  session[:pf]=params[:pf]
			  
			 end
		end
		params[:id]
			@stories = Story.all
		end
	
	
	
end
