class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.references :bracket, null: false, foreign_key: true

      t.references :competitor1, null: false, foreign_key: { to_table: :registrations }
      t.references :competitor2, foreign_key: { to_table: :registrations } # can be nil, in case of bye
      
      t.references :winner, foreign_key: { to_table: :registrations }
      t.string :win_type
      # win time
      # t.integer :win_time_minutes
      # t.integer :win_time_seconds

      t.integer :points1, null: false, default: 0
      t.integer :points2, null: false, default: 0

      t.integer :advantages1, null: false, default: 0
      t.integer :advantages2, null: false, default: 0

      t.integer :penalties1, null: false, default: 0
      t.integer :penalties2, null: false, default: 0

      t.timestamps
    end
  end
end
