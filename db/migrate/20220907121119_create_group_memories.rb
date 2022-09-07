class CreateGroupMemories < ActiveRecord::Migration[6.1]
  def change
    create_table :group_memories do |t|

      t.timestamps
    end
  end
end
