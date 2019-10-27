class Votes < ActiveRecord::Migration[6.0]
  def change
  	add_column :solutions, :upvote, :integer, :default => 0
  	add_column :solutions, :downvote, :integer, :default => 0
  end
end
