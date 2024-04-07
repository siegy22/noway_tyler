class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :role, null: false
      t.string :riot_id, null: false
      t.string :summoner_id, null: false
      t.string :puuid, null: false
      t.integer :profile_icon_id, null: false
      t.integer :summoner_level, null: false
      t.integer :ordering

      t.timestamps
    end
  end
end
