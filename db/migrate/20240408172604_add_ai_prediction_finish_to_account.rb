class AddAIPredictionFinishToAccount < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :ai_prediction_finish, :date
  end
end
