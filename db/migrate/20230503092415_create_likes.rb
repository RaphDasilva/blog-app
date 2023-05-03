class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.bigint :post_id
      t.bigint :user_id

      t.timestamps
    end
    add_index :likes, :post_id
    add_index :likes, :user_id
  end
end
