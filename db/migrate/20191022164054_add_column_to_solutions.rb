class AddColumnToSolutions < ActiveRecord::Migration[6.0]
  def change
    add_column :solutions, :progress, :string
  end
end
