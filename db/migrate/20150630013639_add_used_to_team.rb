class AddUsedToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :used, :text
  end
end
