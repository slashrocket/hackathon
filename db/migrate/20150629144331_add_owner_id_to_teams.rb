class AddOwnerIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :owner_id, :integer
  end
end
