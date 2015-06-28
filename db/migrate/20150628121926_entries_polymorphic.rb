class EntriesPolymorphic < ActiveRecord::Migration
  def change
    change_table(:entries) do |t|
      t.references :ownable, polymorphic: true
    end
  end
end
