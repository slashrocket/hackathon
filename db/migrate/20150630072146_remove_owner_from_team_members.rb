class RemoveOwnerFromTeamMembers < ActiveRecord::Migration
  def change
    remove_column :team_members, :owner
  end
end
