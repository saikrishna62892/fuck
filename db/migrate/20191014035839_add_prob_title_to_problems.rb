class AddProbTitleToProblems < ActiveRecord::Migration[6.0]
  def change
    add_column :problems, :prob_title, :string
  end
end
