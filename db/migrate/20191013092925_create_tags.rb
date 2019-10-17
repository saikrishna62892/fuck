class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.date :deadline
      t.boolean :payment
      t.boolean :internship
      t.boolean :urgency
      t.boolean :miscellaneous
      t.string :dot
      t.string :type
      t.string :difficulty
      t.string :branch

      t.timestamps
    end
  end
end
