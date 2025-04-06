class CreateFriendships < ActiveRecord::Migration[7.2]
  def change
    create_table :friendships do |t|
      t.references :primary_friend, null: false, foreign_key: true
      t.references :secondary_friend, null: false, foreign_key: true

      t.timestamps
    end
  end
end
