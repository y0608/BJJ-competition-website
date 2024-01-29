class CreateWeightclasses < ActiveRecord::Migration[7.1]
  def change
    create_table :weightclasses do |t|
      t.references :bracket, null: false, foreign_key: true

      t.string :age, null: false
      t.string :belt, null: false
      t.string :sex, null: false
      t.float :weight, null: false

      t.timestamps
    end
  end
end