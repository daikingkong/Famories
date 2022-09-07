class CreateMemoryFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :memory_favorites do |t|
      t.integer :end_user_id, null: false
      t.integer :memory_id, null: false

      t.timestamps
    end
  end
end
