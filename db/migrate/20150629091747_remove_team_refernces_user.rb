class RemoveTeamReferncesUser < ActiveRecord::Migration
    def change
    remove_reference(:users, :team, index: true)
  end
end
