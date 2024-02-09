class AddPlacesToBrackets < ActiveRecord::Migration[7.1]
  def change
    add_reference :brackets, :first_place, foreign_key: { to_table: :entries, deferable: :deferred }
    add_reference :brackets, :second_place, foreign_key: { to_table: :entries, deferable: :deferred }
    add_reference :brackets, :third_place, foreign_key: { to_table: :entries, deferable: :deferred }
  end
end