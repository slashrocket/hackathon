class RemoveUserReferencesinEntries < ActiveRecord::Migration
  def change
    remove_reference(:entries, :user, index: true, foreign_key: true)
  end
end
