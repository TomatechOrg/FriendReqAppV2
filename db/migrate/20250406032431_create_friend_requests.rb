class CreateFriendRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :friend_requests do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
  # add_foreign_key :friend_requests, :users, column: :sender
  # add_foreign_key :friend_requests, :users, column: :receiver
end
