class CreateProblems < ActiveRecord::Migration[6.0]
  def change
    create_table :problems do |t|
      t.string :prob_subject
      t.text :prob_description

      t.timestamps
    end
  end
end
