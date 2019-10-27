class SuggestionBoxMailer < ApplicationMailer
	def suggestion(user,subject)
    @user = user
    @subject = subject
    mail to: "publishersubscriberpsp@gmail.com", subject: "Suggestion from #{@user.username}"
  end
end
