class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :incoming_requests, class_name: :FriendRequest, dependent: :destroy, foreign_key: :receiver_id
  has_many :outgoing_requests, class_name: :FriendRequest, dependent: :destroy, foreign_key: :sender_id
  # finds friendships where user is either a primary or secondary friend
  has_many :friendships, ->(user) { where("primary_friend_id = ? OR secondary_friend_id = ?", user.id, user.id) }
end
