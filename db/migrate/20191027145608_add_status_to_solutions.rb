class AddStatusToSolutions < ActiveRecord::Migration[6.0]
  def change
    add_column :solutions, :status, :string, :default =>  'pending'
  end
end
