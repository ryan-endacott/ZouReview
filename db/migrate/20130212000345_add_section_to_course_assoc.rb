class AddSectionToCourseAssoc < ActiveRecord::Migration
  def change
    change_table :sections do |t|
      t.references :course
    end
  end
end
