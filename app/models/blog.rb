class Blog < ApplicationRecord
	acts_as_followable
	 mount_uploader :image, AvatarUploader
	 acts_as_votable
     has_many :comments, dependent: :destroy
end
