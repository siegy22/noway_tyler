class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.belongs_to :account, foreign_key: true, null: false
      t.string :riot_id, null: false
      t.string :role, null: false
      t.boolean :win, null: false
      t.datetime :started_at, null: false

      t.timestamps
    end
  end
end
