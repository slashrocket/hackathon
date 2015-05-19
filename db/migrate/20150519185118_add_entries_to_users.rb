class AddEntriesToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :entries, index: true, foreign_key: true
  end
end
