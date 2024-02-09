class CreateEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :entries do |t|
      t.references :competitor, null: false, foreign_key: { to_table: :users } 
      t.references :bracket, null: false, foreign_key: true

      t.timestamps
    end
  end
end