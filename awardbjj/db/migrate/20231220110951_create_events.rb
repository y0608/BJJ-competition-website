class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.datetime :start_at
      t.datetime :end_at
      t.text :description

      t.references :organizer, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
