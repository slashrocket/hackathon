class AddEntriesToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :entries, index: true
    add_foreign_key :entries, :users
  end
end
