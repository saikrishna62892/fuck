class Samp < ActiveRecord::Migration[6.0]
  def change
  	add_column :solutions, :liked, :boolean ,:default=> false
  end
end
