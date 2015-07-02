class AddSourceCodeRepoToEntriesTable < ActiveRecord::Migration
  def change
    add_column :entries, :source_code_url, :text
  end
end
