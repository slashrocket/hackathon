class ReferenceUsersToTeam < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :team, index: true
    end
  end
end
