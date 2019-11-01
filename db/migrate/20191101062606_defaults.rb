class Defaults < ActiveRecord::Migration[6.0]
  def change
  	change_column :tags, :payment , :boolean, default: false
  	change_column :tags, :internship , :boolean, default: false
  	change_column :tags, :urgency , :boolean, default: false
  	change_column :tags, :miscellaneous , :boolean, default: false
  	change_column :tags, :branch , :string, default: "Not Specific"
  	change_column :tags, :difficulty , :string, default: "Not Specific"
  end
end
