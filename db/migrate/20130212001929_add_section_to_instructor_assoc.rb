class AddSectionToInstructorAssoc < ActiveRecord::Migration
  def change
    change_table :sections do |t|
      t.references :instructor
    end
  end
end
