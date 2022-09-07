class CreateMemoryTags < ActiveRecord::Migration[6.1]
  def change
    create_table :memory_tags do |t|

      t.timestamps
    end
  end
end
