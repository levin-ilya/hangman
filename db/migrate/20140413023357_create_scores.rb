class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.belongs_to :player
      t.integer :win
      t.integer :lost

      t.timestamps
    end
  end
end
