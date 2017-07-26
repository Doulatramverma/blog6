class Blog < ApplicationRecord
	acts_as_followable
	 mount_uploader :image, AvatarUploader
	 acts_as_votable

end
