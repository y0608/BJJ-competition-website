class ChangeNameDefaults < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :first_name, from: "", to: nil
    change_column_default :users, :last_name, from: "", to: nil
    change_column_default :users, :organization_name, from: "", to: nil
  end
end
