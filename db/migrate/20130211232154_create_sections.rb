class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :number
      t.string :term
      t.integer :num_a
      t.integer :num_b
      t.integer :num_c
      t.integer :num_d
      t.integer :num_f
      t.float :avg_gpa

      t.timestamps
    end
  end
end
