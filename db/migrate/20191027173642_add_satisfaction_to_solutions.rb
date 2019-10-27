class AddSatisfactionToSolutions < ActiveRecord::Migration[6.0]
  def change
    add_column :solutions, :satisfaction, :string ,:default=> "Not Reviewed"
  end
end
