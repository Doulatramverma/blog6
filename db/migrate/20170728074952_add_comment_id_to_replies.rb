class AddCommentIdToReplies < ActiveRecord::Migration[5.0]
  def change
    add_column :replies, :comment_id, :integer
  end
end
