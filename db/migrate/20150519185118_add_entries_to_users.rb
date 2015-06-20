class AddEntriesToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :entry, index: true
  end
end
