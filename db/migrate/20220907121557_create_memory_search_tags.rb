class CreateMemorySearchTags < ActiveRecord::Migration[6.1]
  def change
    create_table :memory_search_tags do |t|

      t.timestamps
    end
  end
end
