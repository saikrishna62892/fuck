class UsersController < ApplicationController
	add_flash_types :danger,:info, :success,:warning
  @global_problem = nil
  def index
  	# flash[:info] = "Welcome to PSP site!!"
  end
  def users
    @users=User.all
  end
  def home_search
  	search=home_search_params[:search]
  	redirect_to "https://www.google.com/search?client=ubuntu&channel=fs&q=#{search}&ie=utf-8&oe=utf-8", target: :_blank
    #render <%= link_to 'Google', 'google.com', :target => '_blank' %>
  end
  def user_search
    search = user_search_params[:search]
    @user = User.find_by(username: search)
    if @user
      redirect_to user_profile_path(@user)
    else
      flash[:danger] = "User Not Found!!"
    end
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
    #@problem=Problem.create(problem_params2)
    @user = current_user
    @problem = @user.problems.new(problem_params2)
    if @problem.save
      @tag=@problem.tags.new(:deadline=> problem_params1[:deadline],:payment=> params[:payment][:result],:internship=> params[:internship][:result],:urgency=> params[:urgency][:result],:miscellaneous=> params[:miscellaneous][:result],:dot=> problem_params1[:dot],:type=> problem_params1[:type],:difficulty=> problem_params1[:difficulty_level],:branch=> problem_params1[:branch])
      @tag.save
      redirect_to wall_path,success: "Problem Created Succesfully!!"
    else
      # flash[:danger]="Something went wrong!!"
      render 'post_problem'
    end
    #@pdf =@problem.attachment.attachment
  end
  def wall(problems = Problem.all)
    @problems = problems
    render 'wall'
  end
  def filter_tags
    filter_tag_params={
      "payment1" => params[:payment][:result],
      "internship1" => params[:internship][:result],
      "urgency1" => params[:urgency][:result],
      "miscellaneous1" => params[:miscellaneous][:result],
      "branch1" => filter_params[:branch],
      "difficulty1" => filter_params[:difficulty]
    }
    tags1 = Tag.where(nil)
    filter_tag_params.each do |key, value|
      if value!="0" && value!=""
        tags1 = tags1.public_send(key, value)
      end
    end
    problemids=tags1.select(:problem_id)
    problems=Problem.where(:id => problemids)
    wall(problems)
  end
  def view_problem
    @prob_id = params[:id]
    @view = Problem.find(@prob_id)


  end

  def myPostedProblems
    @user = current_user
    @posted_problems = @user.problems



  end
  def myPostedSolutions
      @user = current_user
      @posted_solutions = @user.solutions
     # @prob = nil
  end
  def sentRequests
      @user = current_user
      @sent_requests = @user.request_accesses
  end

  def viewRequests
    @problem = Problem.find(params[:prob_id])
    @requests = @problem.request_accesses

  end

  def grantAccess

    @request = RequestAccess.find(params[:request_id])
    @request.update(:grant_access => true )
    redirect_to user_posted_problems_url(current_user)

  end

  def post_solution
    probid=params[:prob_id]
    @problem = Problem.find(probid)
    @user=current_user
    @solution = Solution.where(:problem_id => probid, :user_id => @user.id)

    
    if( !@solution.present?)
       @sol=@problem.solutions.new(post_solution_params)
       @sol.user_id = @user.id

    if @sol.save
        redirect_to view_problem_path(@problem)
     end
 else
    #debugger
    @solution.update(post_solution_params)

    redirect_to view_problem_path(@problem)
  end 
    #@solution = Solution.create(post_solution_params)


  end
  def request_access
      @probid = params[:prob_id]
      @user = current_user
      @access = RequestAccess.where(:problem_id => @probid, :user_id => @user.id)
      #render plain: @access.inspect
      if(@access.present?)
        redirect_to wall_path,danger:"Request already made!!"
      else
        @req = RequestAccess.new(:problem_id => @probid,:user_id => @user.id)
        if @req.save
        redirect_to wall_path,success:"Request made Succesfully!!"
        else
        redirect_to wall_path,danger:"Oops!!,Something Went Wrong"
        end
      end
  end


  private
	def home_search_params
		params.require(:home_search).permit(:search)
	end
  def user_search_params
    params.require(:user_search).permit(:search)
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
  def filter_params
    params.require(:filter_tags).permit(:branch,:difficulty)
  end

  def signup_params
    params.require(:signup).permit(:username,:firstname,:lastname,:dob,:email,:password,:password_confirmation,:gender)
  end
  def editform_params
    params.require(:editform).permit(:username,:firstname,:lastname,:dob,:email,:avatar,:qualification,:skills,:about)
  end
  def post_solution_params
    params.require(:solution).permit(:comment,:progress,:attachment)
  end
end
