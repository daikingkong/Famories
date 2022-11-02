class CreateGroupMemories < ActiveRecord::Migration[6.1]
  def change
    create_table :group_memories do |t|
      t.integer :end_user_id, null: false
      t.integer :group_id, null: false
      t.string :title, null: false
      t.text :memo, null: false

      t.timestamps
      t.index [:group_id, :end_user_id]
    end
  end
end
