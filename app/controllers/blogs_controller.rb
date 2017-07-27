class BlogsController < ApplicationController
	 before_action :authenticate_user!
	def index
       @blogs=Blog.all

	end

	def new
		@blog=Blog.new
	end

	def create
		@blog=Blog.new(blog_params)
		@blog.user_id = current_user.id
		@blog.save
		redirect_to @blog
	end
         

	def show
		@blog=Blog.find(params[:id])
    end
      
  def friend
      if Friendship.where(sender: current_user.id,receiver: params[:id], accept: false).first.present?
          flash[:notice] = "you have already sent the friend  request to this user"

      elsif Friendship.where(sender: current_user.id,receiver: params[:id], accept: true).first.present?
       
            flash[:notice] = "You are already friend of this user"  
        else
            Friendship.create(sender: current_user.id,receiver: params[:id], accept: false )
            flash[:notice] = "freind request sent"  
        end
  
   redirect_to blog_profile_path(id: current_user.id)
end

def accept_friend
  @abc=Friendship.where(receiver: params[:re] ,sender: params[:se]).first
  @abc.update(accept: true)
      flash[:notice] = "Now you are friend with #{User.where(id: params[:se]).first.email}"
    redirect_to blog_profile_path(id: current_user.id)
end
def delete_friend
  @abc=Friendship.where(receiver: params[:re] ,sender: params[:se]).first
  @abc.destroy
   flash[:notice] = "request deleted"
  redirect_to blog_profile_path(id: current_user.id)
end
  # def notification

  #  @likenotifications= Notification.where(recipient_id: current_user.id,notifiable_for: "like")
  #   @dislikenotifications= Notification.where(recipient_id: current_user.id,notifiable_for: "dislike")
    
  # end

  # GET /users/:id.:format
  def profile

   if Friendship.where(receiver: current_user.id).first.present?
      @friend_request=Friendship.where(receiver: current_user.id)
    end 

     @user = User.all.where.not(id: current_user)
    
      

    if Friendship.where(receiver: current_user.id).first.present? || Friendship.where(sender: current_user.id).first.present?

      @friends = Friendship.where(receiver: current_user.id)
    
       @friends1 = Friendship.where(sender: current_user.id)
    end

  end



  def upvote
   @blog = Blog.find(params[:id])
   @blog.upvote_by current_user
   
    redirect_to :back 

  end

  def downvote
   @blog = Blog.find(params[:id])
   @blog.downvote_by current_user
   
    redirect_to :back 
 end

 def follow

   # if Follow.where(follower_id: params[:id], follower_type: "User",followable_id: params[:id],followable_type: "ApplicationRecord").first.present? 
    @follow= Follow.create(follower_id: params[:id], followable_id: current_user.id,follower_type: "User",followable_type: "ApplicationRecord") 
    # end
    redirect_to :back 
  end 

 def unfollow 
   
   #if Follow.where(follower_id: params[:id], follower_type: "User").first.present?
    @unfoll = Follow.where(follower_id: params[:id], follower_type: "User",followable_id: current_user.id).first
    
    @unfollow = @unfoll.destroy
    #end
  
    redirect_to :back 
 end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
 
    if @blog.update(blog_params)
      redirect_to @blog
      else
      render 'edit'
     end
  end 

  def my_blog
    @blogs= Blog.where(:user_id => current_user.id)
  end



  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
 
    redirect_to blogs_path
  end
 

  private
  def blog_params
    params.require(:blog).permit(:title, :description, :image)
  end

end
