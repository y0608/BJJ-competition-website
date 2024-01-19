class AddGameTypeToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :game_type, :string, null: false, default: 'NoGi' 
  end
end
