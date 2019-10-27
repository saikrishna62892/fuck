class UserMailer < ApplicationMailer

	def email_verifier user 
		@user =user
		@urll = "https://workcollabwc.herokuapp.com/verifier/"+@user.id.to_s+"/"+@user.otp.to_s
		mail to: @user.email, subject: "Verification needed from PSP"



	end

end
