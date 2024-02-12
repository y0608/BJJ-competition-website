class CreateBrackets < ActiveRecord::Migration[7.1]
  def change
    create_table :brackets do |t|
      t.references :event, null: false, foreign_key: true
      t.integer :rounds, default: 0, null: false

      t.timestamps
    end
  end
end
