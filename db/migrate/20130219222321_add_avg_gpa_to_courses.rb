class AddAvgGpaToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :avg_gpa, :float
  end
end
