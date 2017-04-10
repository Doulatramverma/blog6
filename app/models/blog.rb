class Blog < ApplicationRecord
	 mount_uploader :image, AvatarUploader
end
