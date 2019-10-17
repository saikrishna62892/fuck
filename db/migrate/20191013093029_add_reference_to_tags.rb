class AddReferenceToTags < ActiveRecord::Migration[6.0]
  def change
  	add_reference :tags,:problem
  end
end
