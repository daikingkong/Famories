class CreateMemories < ActiveRecord::Migration[6.1]
  def change
    create_table :memories do |t|
      t.integer :end_user_id, null: false
      t.string :title, null: false
      t.text :memo, null: false

      t.timestamps
    end
  end
end
