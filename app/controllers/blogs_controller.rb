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
