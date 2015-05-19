class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :name
      t.text :url
      t.text :about
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
