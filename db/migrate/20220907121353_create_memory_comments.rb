class CreateMemoryComments < ActiveRecord::Migration[6.1]
  def change
    create_table :memory_comments do |t|
      t.integer :end_user_id, null: false
      t.integer :memory_id, null: false
      t.text :comment, null:false

      t.timestamps
      t.index [:memory_id, :end_user_id]
    end
  end
end
