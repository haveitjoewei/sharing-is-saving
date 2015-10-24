class Api::V1::Post::PostController < ApplicationController
  	skip_before_action :verify_authenticity_token 
	skip_before_filter :authenticate_user!, :only => [:index, :show]
	skip_before_filter :authenticate_user_from_token!, :only => [:index, :show]
  	respond_to :json

	# POST /api/v1/posts(.:format)
	# create one post
	def create
		@user = User.find_by_authentication_token(request.headers['X-API-TOKEN'])
        if @user
        	@post = ::Post.new(post_params.merge!(user: @user))
			respond_to do |format|
				format.json {
					if @post.save
						newPost = ActiveSupport::JSON.decode @post.to_json
						newPost['created_at'] = @post.created_at.to_f
						newPost['updated_at'] = @post.updated_at.to_f
						newPost['status'] = 1 # TODO (Koji) 1 means it's
						render :json => {:status => 1, :post => newPost}, :status => 201
					else
						render :json => {:status => -1, :errors => @post.errors.full_messages} #TODO, status
					end
				}
			end
        else
          render :json => {:status => -1, :message => 'Couldn\'t create post because token is invalid.' }, :status => 404 # TODO. why 404? why not 401
    	  response.headers['Access-Control-Allow-Origin'] = "*" # * means any. specify to 
    end

		
	end

	# helper for checking if a float is a price
	def isTwoDecimals(a)
    	num = 0
    	while(a != a.to_i)
        	num += 1
        	a *= 10
    	end
    	num == 2
	end

	# GET /api/v1/posts(.:format)   
	# gets all posts
	def index
		allPosts = ::Post.all.order(:created_at).reverse_order # gets all posts, apply filters
		if params.has_key?(:user)
			allPosts = allPosts.where("user_id = ?", params[:user])
		end
		postArray = Array.new
		allPosts.each do |post|
			newPost = ActiveSupport::JSON.decode post.to_json
			newPost['created_at'] = post.created_at.to_f
			newPost['updated_at'] = post.updated_at.to_f
			postArray.push newPost
		end
		render :json => {:status => 1, :post => postArray}
		response.headers['Access-Control-Allow-Origin'] = "*"# * means any. specify to 
	end

	# GET /api/v1/posts/:id(.:format)
	# gets one post
	def show
		begin
			onePost = ::Post.find(params[:id])
			rescue ActiveRecord::RecordNotFound  
	        render :json => {:status => -1, :message => 'Couldn\'t find post because post does not exist.' }, :status => 404
			return
		end
		newPost = ActiveSupport::JSON.decode onePost.to_json
		newPost['created_at'] = onePost.created_at.to_f
		newPost['updated_at'] = onePost.updated_at.to_f
		
		response.headers['Access-Control-Allow-Origin'] = "*"# * means any. specify to 
		render :json => {:status => 1, :post => newPost}
	end		

	# DELETE /api/v1/posts/:id(.:format) 
	# deletes one post
	def destroy
		currentUserId = current_user.id
		postId = params[:id]
		response.headers['Access-Control-Allow-Origin'] = "*"# * means any. specify to 
		begin
			thePost = ::Post.find(postId)
			rescue ActiveRecord::RecordNotFound  
            render :json => {:status => -1, :message => 'Couldn\'t delete post because post does not exist.' }, :status => 404
			return
		end

		if thePost.user_id == currentUserId # Delete the post
			::Post.delete(params[:id])
			render :json => {:status => 1}
			return 
		else
			render :json => {:status => -1, :message => 'User does not have permissions to delete this post.' }, :status => 404
			return
		end
	end

	# DELETE /api/v1/users/:user_id/posts(.:format)
	# def destroyAll
	# 	byebug
	# 	::Post.where("user_id = ?", params[:user_id]).delete_all
	# 	render :json => {'status' => 1}
	# end

	private
		def post_params
			params.require(:post).permit(:title, :latitude, :longitude, :description, :price, :security_deposit, :user, :status)
		end

end
