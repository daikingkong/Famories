class CreateJoinRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :join_requests do |t|
      t.integer :end_user_id, null: false
      t.integer :group_id, null: false

      t.timestamps
    end
  end
end
