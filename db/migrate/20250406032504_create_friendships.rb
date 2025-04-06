class CreateFriendships < ActiveRecord::Migration[7.2]
  def change
    create_table :friendships do |t|
      t.references :primary_friend, null: false, foreign_key: { to_table: :users }
      t.references :secondary_friend, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
  # add_foreign_key :friendships, :users, column: :primary_friend
  # add_foreign_key :friendships, :users, column: :secondary_friend
end
