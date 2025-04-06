class Friendship < ApplicationRecord
  belongs_to :primary_friend, class_name: :User, foreign_key: :primary_friend_id
  belongs_to :secondary_friend, class_name: :User, foreign_key: :secondary_friend_id
end
