class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.references :bracket, null: false, foreign_key: true

      t.integer :status, null: false, default: 0 # 0 = not started, 1 = in bull pen (aka just before playing), 2 = playing, 3 = finished

      t.references :next_match, foreign_key: { to_table: :matches }
      t.integer :round, null: false, default: 0 # 0 = final, 1 = semi-final, ...

      t.references :competitor1, foreign_key: { to_table: :users }
      t.references :competitor2, foreign_key: { to_table: :users }
      
      # FUTURE: used for ETA
      # t.datetime :win_time
      # t.datetime :end_time
      # t.datetime :start_time

      t.float :timer_value, null: false, default: 300 # in seconds
      t.datetime :timer_last_started_at
      t.boolean :timer_running, null: false, default: 0

      t.integer :points1, null: false, default: 0
      t.integer :points2, null: false, default: 0

      t.integer :advantages1, null: false, default: 0
      t.integer :advantages2, null: false, default: 0

      t.integer :penalties1, null: false, default: 0
      t.integer :penalties2, null: false, default: 0

      t.references :winner, foreign_key: { to_table: :users }
      t.integer :win_type

      t.timestamps
    end
  end
end
