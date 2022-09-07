class CreateMemoryFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :memory_favorites do |t|

      t.timestamps
    end
  end
end
