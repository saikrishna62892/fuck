class AddApproveToSolutions < ActiveRecord::Migration[6.0]
  def change
    add_column :solutions, :approve, :boolean, :default => false
  end
end
