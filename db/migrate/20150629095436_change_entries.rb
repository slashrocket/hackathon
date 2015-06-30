class ChangeEntries < ActiveRecord::Migration
  def change
    change_column :entries, :name, :string
    change_column :entries, :url, :string
  end
end
