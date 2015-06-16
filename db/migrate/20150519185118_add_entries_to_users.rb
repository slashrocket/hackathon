class AddEntriesToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :entries, index: true
  end
end
