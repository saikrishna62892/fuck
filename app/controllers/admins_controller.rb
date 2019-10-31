class AdminsController < ApplicationController
  add_flash_types :danger,:info, :success,:warning
	skip_before_action :require_login, only: [:index, :show, :monthly_report, :stat, :afilter_tags,:weekly_report]
  @global = 5
  def index
  
  end

def show
  @flag = params[:bid]
  admin_id = params[:id]
  if @flag.present? 
    if @flag=="1"
      @monthly_data = Array.new
      @monthly_data = monthly_report
      #render plain:@monthly_data.inspect

    end
    if @flag=="2"
      @weekly_data = Array.new
      @weekly_data = weekly_report
    end 
  end

end
  def weekly_report
    week_data = Array.new
    date = Date.today-7
  @m_problems = Problem.where("created_at>?",date)
  @m_solutions = Solution.where("created_at>?",date)
  # require "prawn-table"
  # require "prawn"

  Prawn::Document.generate("#{Rails.root}/public/Weekly_Report.pdf") do |pdf|
    table_data = Array.new
    pdf.text "Weekly Report"
    pdf.text "\n\n"


    pdf.text "\n\nProblem & Solutions posted"
    table_data << ["Problem Title","No of Solutions Posted"]
    @m_problems.each do |p|
      table_data << [p.prob_title, p.solutions.count]
    end
    pdf.table(table_data, :width => 500, :cell_style => { :inline_format => true })
    pdf.text "\n\nTotal Problems posted: "+ @m_problems.count.to_s
    pdf.text "\nTotal Solutions posted: "+ @m_solutions.count.to_s


    pdf.text "\n\nMost Viewed problems(top 5)"
    table_data1 = Array.new
    table_data1 << ["Problem Title","Total Views"]
    @most_viewed = @m_problems.order("views DESC").limit(5)
    @most_viewed.each do |p|
      table_data1 << [p.prob_title, p.views]
    end
    pdf.table(table_data1, :width => 500, :cell_style => { :inline_format => true })


    pdf.text "\n\nTop UpVoted problems(top 5)"
    table_data2 = Array.new
    table_data2 << ["Problem Title","Solution given by","UpVote Count"]
    @most_voted_sols = @m_solutions.order("upvote DESC").limit(5)
    @most_voted_sols.each do |sol|
      table_data2 << [Problem.find(sol.problem_id).prob_title, User.find(sol.user_id).username,sol.upvote]
    end
    pdf.table(table_data2, :width => 500, :cell_style => { :inline_format => true })


    pdf.text "\n\nTop DownVoted problems(top 5)"
    table_data3 = Array.new
    table_data3 << ["Problem Title","Solution given by","DownVote Count"]
    @most_dvoted_sols = @m_solutions.order("downvote DESC").limit(5)
    @most_dvoted_sols.each do |sol|
      table_data3 << [Problem.find(sol.problem_id).prob_title, User.find(sol.user_id).username,sol.downvote]
    end
    pdf.table(table_data3, :width => 500, :cell_style => { :inline_format => true })
    
    week_data[0] = table_data
    week_data[1] = table_data1
    week_data[2] = table_data2
    week_data[3] = table_data3
    

  end
  return week_data
end

 def monthly_report
  #debugger
month_data = Array.new
 	date = Date.today-30
  @m_problems = Problem.where("created_at>?",date)
  @m_solutions = Solution.where("created_at>?",date)
  # require "prawn-table"
  # require "prawn"

  Prawn::Document.generate("#{Rails.root}/public/Monthly_Report.pdf") do |pdf|
    table_data = Array.new
#render plain:@m_problems.inspect

    pdf.text "Monthly Report"
    pdf.text "\n\n"


    pdf.text "\n\nProblem & Solutions posted"
    table_data << ["Problem Title","No of Solutions Posted"]

    @m_problems.each do |p|
      table_data << [p.prob_title, p.solutions.count]
    end
    pdf.table(table_data, :width => 500, :cell_style => { :inline_format => true })
    pdf.text "\n\nTotal Problems posted: "+ @m_problems.count.to_s
    pdf.text "\nTotal Solutions posted: "+ @m_solutions.count.to_s


    pdf.text "\n\nMost Viewed problems(top 5)"
    table_data1 = Array.new
    table_data1 << ["Problem Title","Total Views"]
    @most_viewed = @m_problems.order("views DESC").limit(5)
    @most_viewed.each do |p|
      table_data1 << [p.prob_title, p.views]
    end
    pdf.table(table_data1, :width => 500, :cell_style => { :inline_format => true })


    pdf.text "\n\nTop UpVoted problems(top 5)"
    table_data2 = Array.new
    table_data2 << ["Problem Title","Solution given by","UpVote Count"]
    @most_voted_sols = @m_solutions.order("upvote DESC").limit(5)
    @most_voted_sols.each do |sol|
      table_data2 << [Problem.find(sol.problem_id).prob_title, User.find(sol.user_id).username,sol.upvote]
    end
    pdf.table(table_data2, :width => 500, :cell_style => { :inline_format => true })


    pdf.text "\n\nTop DownVoted problems(top 5)"
    table_data3 = Array.new
    table_data3 << ["Problem Title","Solution given by","DownVote Count"]
    @most_dvoted_sols = @m_solutions.order("downvote DESC").limit(5)
    @most_dvoted_sols.each do |sol|
      table_data3 << [Problem.find(sol.problem_id).prob_title, User.find(sol.user_id).username,sol.downvote]
    end
    pdf.table(table_data3, :width => 500, :cell_style => { :inline_format => true })
    


    month_data[0] = table_data
    month_data[1] = table_data1
    month_data[2] = table_data2
    month_data[3] = table_data3
  end 

    return month_data
 end

 def afilter_tags
 	afilter_tag_params={
 		"payment1" => params[:payment][:result],
      "internship1" => params[:internship][:result],
      "urgency1" => params[:urgency][:result],
       "branch1" => afilter_params[:branch],
      "difficulty1" => afilter_params[:difficulty]
 	}

 	 tags1 = Tag.where(nil)
    afilter_tag_params.each do |key, value|
      if value!="0" && value!=""
        tags1 = tags1.public_send(key, value)
      end
    end
    problemids=tags1.select(:problem_id)
    problems=Problem.where(:id => problemids)
    @problems = problems
   end


  def stat

    date = Date.today-30
    @m_problems = Problem.where("created_at>?",date)
    @m_solutions = Solution.where("created_at>?",date)
    Prawn::Document.generate("#{Rails.root}/public/Problem_stat.pdf") do |pdf|
    table_data = Array.new
    table_data << ["Number of Problems Posted"]
      table_data << [@m_problems.count]

    table_data2 = Array.new
    table_data2 << ["Number of Solutions Posted"]
      table_data2 << [@m_solutions.count]

    table_data3 = Array.new
    table_data3 << ["Number of Unsolved Problems"]
      @total = Problem.all
      @total.each do |pr|
        if pr.solutions.count == 0
          table_data3 << [pr.prob_title]
        end
      end


    pdf.table(table_data, :width => 500, :cell_style => { :inline_format => true })
    pdf.table(table_data2, :width => 500, :cell_style => { :inline_format => true })
    pdf.table(table_data3, :width => 500, :cell_style => { :inline_format => true })
  end

  end


  def afilter_params
    params.require(:afilter_tags).permit(:branch,:difficulty)
  end
  
end
