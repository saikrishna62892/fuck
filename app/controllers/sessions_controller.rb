class SessionsController < ApplicationController
  add_flash_types :danger,:info, :success,:warning



skip_before_action :require_login, only: [:create, :acreate, :adestroy]

  def new
  end

  def create
    # debugger
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) 
      # Log the user in and redirect to the user's show page.
      if user.verified == true
      log_in user
      redirect_to wall_path
    else
      flash[:danger] = "Your account has not been verified yet! Check your mail!"
      redirect_to root_url
    end


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
