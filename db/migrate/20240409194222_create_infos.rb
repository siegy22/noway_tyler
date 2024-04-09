class CreateInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :infos do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :value, null: false

      t.timestamps
    end
  end
end
