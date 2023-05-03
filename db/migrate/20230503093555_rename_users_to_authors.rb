class RenameUsersToAuthors < ActiveRecord::Migration[7.0]
  def change
    def change
      rename_table :users, :authors
      rename_column :posts, :user_id, :author_id
      rename_column :comments, :user_id, :author_id
      rename_column :likes, :user_id, :author_id
    end
  end
end
