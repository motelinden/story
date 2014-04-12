class Users::RegistrationsController < Devise::RegistrationsController
	def if_user_exist?
		respond_to do |format|
			@user = User.find_by(username: params[:username])
			if @user.nil?
				format.json { head :no_content}
			else
				format.json { head :not_acceptable}
			end
		end
	end
end