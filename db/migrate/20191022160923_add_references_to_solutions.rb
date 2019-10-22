class AddReferencesToSolutions < ActiveRecord::Migration[6.0]
  def change
  	add_reference :solutions,:problem
  	add_reference :solutions,:user

  end
end
