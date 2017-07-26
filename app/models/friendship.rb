class Friendship < ApplicationRecord
belongs_to :blog, foreign_key: 'sender', class_name: 'User'
belongs_to :user, foreign_key: 'receiver', class_name: 'User'
end
