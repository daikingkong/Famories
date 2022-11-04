class CreateMemoryFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :memory_favorites do |t|
      t.integer :end_user_id, null: false
      t.integer :memory_id, null: false

      t.timestamps
      t.index [:end_user_id, :memory_id], unique: true
    end
  end
end
