class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :teams, :owner_id
    add_index :teams, :name
    add_index :entries, :name
    add_index :entries, :url
  end
end
