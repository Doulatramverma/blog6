class CommentsController < ApplicationController
    # def create
	   #  @blog = Blog.find(params[:blog_id])
	   #  @comment = @blog.comments.create(comment_params)
	   #  redirect_to blog_path(@blog)
    # end
  def index

     @comments = Comment.all

    # Comment.hash_tree(limit_depth: 2)
  end

  def new
   @comment = Comment.new(parent_id: params[:parent_id])
  end

  def create

    if params[:comment][:parent_id].to_i > 0
      parent = Comment.find_by_id(params[:comment].delete(:parent_id))
      @comment = parent.children.build(comment_params)
     else
      @comment = Comment.new(comment_params)
    end

    if @comment.save
      flash[:success] = 'Your comment was successfully added!'
      redirect_to root_url
       else
      render 'new'
    end
 end
    # def destroy
	   #  @blog = Blog.find(params[:blog_id])
	   #  @comment = @blog.comments.find(params[:id])
	   #  @comment.destroy
	   #  redirect_to blog_path(@blog)
    # end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body,:parent_id)
    end
end

