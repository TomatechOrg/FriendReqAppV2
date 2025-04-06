class CreateFriendRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :friend_requests do |t|
      t.references :sender, null: false, foreign_key: true
      t.references :receiver, null: false, foreign_key: true

      t.timestamps
    end
  end
end
