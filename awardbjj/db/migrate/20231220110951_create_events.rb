class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name, null: false

      t.datetime :start_at, null: false
      t.datetime :end_at

      t.string :location, null: false
      t.string :game_type, default: "NoGi", null: false
      t.text :description

      t.references :organizer, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
