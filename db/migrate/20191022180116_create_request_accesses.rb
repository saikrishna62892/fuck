class CreateRequestAccesses < ActiveRecord::Migration[6.0]
  def change
    create_table :request_accesses do |t|

      t.timestamps
    end
  end
end
