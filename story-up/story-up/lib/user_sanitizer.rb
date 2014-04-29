class User::ParameterSanitizer < Devise::ParameterSanitizer

	def sign_in
		default_params.permit(:username, :email, :password, :remember_me)
	end

	def sign_up
		default_params.permit(:username, :email, :password, :password_confirmation)
	end

	def account_update
		default_params.permit(:username, :email, :password, :password_confirmation, :current_password)
	end
end
