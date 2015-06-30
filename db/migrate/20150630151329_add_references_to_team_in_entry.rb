class AddReferencesToTeamInEntry < ActiveRecord::Migration
  def change
    change_table :entries do |t|
      t.references :team, index: true, foreign_key: true
    end
  end
end
