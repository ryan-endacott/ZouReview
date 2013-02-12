class AddAbbreviationToDept < ActiveRecord::Migration
  def change
    change_table :departments do |t|
      t.string :abbreviation
    end
  end
end
