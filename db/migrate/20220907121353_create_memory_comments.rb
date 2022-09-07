class CreateMemoryComments < ActiveRecord::Migration[6.1]
  def change
    create_table :memory_comments do |t|

      t.timestamps
    end
  end
end
