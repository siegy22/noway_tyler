class CreateEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :entries do |t|
      t.belongs_to :account, foreign_key: true, null: false
      t.string :tier
      t.string :rank
      t.integer :league_points
      t.integer :wins
      t.integer :losses

      t.timestamps
    end
  end
end
