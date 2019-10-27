class AdminsController < ApplicationController
	skip_before_action :require_login, only: [:index]

  def index
end
def show
  end

 def monthly_report
 	date = Date.today-30
 	@m_problems = Problem.where("created_at>?",date)
  # require "prawn-table"
  # require "prawn"

  Prawn::Document.generate("#{Rails.root}/public/Monthly_Report.pdf") do |pdf|
    table_data = Array.new
    table_data << ["Title"]
    @m_problems.each do |p|
      table_data << [p.prob_title]
    end
    pdf.table(table_data, :width => 500, :cell_style => { :inline_format => true })
  end
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
