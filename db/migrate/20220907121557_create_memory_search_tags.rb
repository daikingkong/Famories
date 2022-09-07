class CreateMemorySearchTags < ActiveRecord::Migration[6.1]
  def change
    create_table :memory_search_tags do |t|
      t.integer :memory_tag_id, null: false
      t.integer :memory_id, null: false

      t.timestamps
    end
  end
end
