class CreateMemorySearchTags < ActiveRecord::Migration[6.1]
  def change
    create_table :memory_search_tags do |t|
      t.references :memory, foreign_key: true
      t.references :memory_tag, foreign_key: true
      t.timestamps
    end
    add_index :memory_search_tags, [:memory_id, :memory_tag_id], unique: true
  end
end
