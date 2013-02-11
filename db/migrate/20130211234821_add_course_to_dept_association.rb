class AddCourseToDeptAssociation < ActiveRecord::Migration
  def change
    change_table :courses do |t|
      t.references :department
    end
  end
end
