class UsersController < ApplicationController
	add_flash_types :danger,:info, :success,:warning
  @global_problem = nil
  def index
  	flash[:info] = "Welcome to PSP site!!"
  end
  def home_search
  	search=home_search_params[:search]
  	#redirect_to "https://www.google.com/search?client=ubuntu&channel=fs&q=#{search}&ie=utf-8&oe=utf-8", target: :_blank
    #render <%= link_to 'Google', 'google.com', :target => '_blank' %>
  end
  def suggestion_box
  	user_name=suggestion_box_params[:user_name]
  	subject=suggestion_box_params[:subject]
  	@user = User.where(:user_name => user_name).first
  	#render plain: @user.inspect
  	if @user==nil
			redirect_to index_path, danger: "Username is not valid!!"
		else
			SuggestionBoxMailer.suggestion(@user,subject).deliver_now
			redirect_to index_path, info: "Thankyou for your valuable suggestion!!"
		end
  end
  

#signup to debugpage methods are done by hemanth

 def signup
  end

  def signningUp

    @user = User.new(signup_params)

    @user.otp = rand 100000..999999

    if @user.save
      
    UserMailer.email_verifier(@user).deliver_now
     flash[:success]="Signup successful"
      redirect_to root_url    

    else

      flash[:danger]="Signup failed"
      render 'signup'
    end
    
  end


  def verifier   #this function is goig to check otp that is coming from email check routes for more info

    @user = User.find(params[:user_id])
    if @user.otp == params[:otp]
      @user.verified = true;
      redirect_to user_edit_profile_url(@user)
    end

  end

  def profile

  @user =User.find_by(id: params[:user_id])
  end

def edit

@user =User.find_by(id: params[:user_id])

end

def save
#render plain:editform_params.inspect
@user =User.find_by(id: params[:user_id])
@user.update(editform_params)
#render plain:params[:editform][:email].inspect

redirect_to user_profile_url(@user)

  end

def debugpage
end

def debug
end

#signup to debugpage methods are done by hemanth

  

  


  def post_problem
  end
  def show_attachments
    @attachments = Problem.find(49).attachment


  end
  def getProblemDetails
    #render plain:params[:payment][:result].inspect
    @problem=Problem.create(problem_params2)
    if @problem.save
      @tag=@problem.tags.new(:deadline=> problem_params1[:deadline],:payment=> params[:payment][:result],:internship=> params[:internship][:result],:urgency=> params[:urgency][:result],:miscellaneous=> params[:miscellaneous][:result],:dot=> problem_params1[:dot],:type=> problem_params1[:type],:difficulty=> problem_params1[:difficulty_level],:branch=> problem_params1[:branch])
      @tag.save
      redirect_to wall_path,success: "Problem Created Succesfully!!"
    else
      flash[:danger]="Something went wrong!!"
      render '/post_problem'
    end
    #@pdf =@problem.attachment.attachment
  end
  def wall
  end
  def filter_tags
    @prob = Tag.joins(:problem).where(:branch=> filter_tag_params[:branch]).select(:problem_id)
    @global_problem = Problem.where(id: @prob)
    render plain: @x.inspect
  end
  private
	def home_search_params
		params.require(:home_search).permit(:search)
	end
	def suggestion_box_params
		params.require(:suggestion_box).permit(:user_name,:subject)
	end
  def problem_params1
    params.require(:problem).permit(:type,:urgency,:internship,:payment,:miscellaneous,:branch,:difficulty_level,:dot,:deadline,:attachment)
  end
  def problem_params2
    params.require(:problem).permit(:prob_title,:prob_subject,:prob_description,:attachment)
  end
  def filter_tag_params
    params.require(:filter_tags).permit(:payment,:internship,:urgency,:miscellaneous,:branch,:difficulty)
  end

  def signup_params
    params.require(:signup).permit(:username,:firstname,:lastname,:dob,:email,:password,:password_confirmation)
  end
  def editform_params
    params.require(:editform).permit(:username,:firstname,:lastname,:dob,:email,:avatar,:qualification,:skills,:about)
  end
end
