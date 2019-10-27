class SessionsController < ApplicationController
  def new
  end

  def create
    # debugger
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      redirect_to wall_path


    else
      # Create an error message.
      flash[:danger] = 'Invalid email/password combination'
      redirect_to root_url
    end
  end

  def destroy
  	#debugger
    log_out
    redirect_to root_url
  end


 def acreate

  temp={adminame: params[:session][:adminame], password: params[:session][:password]}
  @admin = Admin.find_by(temp)
  if @admin.present?
    @id = alog_in @admin
    redirect_to '/admins/show/'+@id.to_s
  else
    # flash[:danger] = "Invalid Name/password Combination"
    redirect_to '/admins/index' 
  end
  end

  def adestroy
    #debugger
    alog_out
    redirect_to root_url
  end


end
