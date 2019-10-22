class AddReferencesToRequestAccesses < ActiveRecord::Migration[6.0]
  def change
  	 add_column :request_accesses, :grant_access, :boolean
  	add_reference :request_accesses,:problem
  	add_reference :request_accesses,:user
  end
end
