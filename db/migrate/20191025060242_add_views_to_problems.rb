class AddViewsToProblems < ActiveRecord::Migration[6.0]
  def change
    add_column :problems, :views, :integer, :default => 0
  end
end
