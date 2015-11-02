class Api::V1::Post::PostController < ApplicationController
	skip_before_action :verify_authenticity_token 
	skip_before_filter :authenticate_user!, :only => [:index, :show]
	skip_before_filter :authenticate_user_from_token!, :only => [:index, :show]
	respond_to :json

	# POST /api/v1/posts(.:format)
	# create one post
	def create
		@user = current_user
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
		
	end

	# GET /api/v1/posts(.:format)   
	# gets all posts
	def index
		allPosts = ::Post.all.order(:created_at).reverse_order # gets all posts, apply filters

		# Location filtering
		if params.has_key?(:radius) and params.has_key?(:center)
			allPosts = filter_by_radius_and_center(allPosts); return if performed?
		end

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

	def filter_by_radius_and_center(allPosts)
		errorsArr = Array.new
		if !params[:center].include? "," # Crucial error
			errorsArr.push('Center does not have both latitude and longitude. Please make sure to separate them, e.g. center=37.152,38.100.')
			render render_errors(errorsArr)
		end

		begin
			latLon = params[:center].split(',')
			latitude = Float(latLon[0])
			longitude = Float(latLon[1])
			radius = Float(params[:radius])
		rescue ArgumentError
			errorsArr.push('Radius or center cannot be parsed as numbers.') # Crucial error
			return render_errors(errorsArr)
		end

		if radius > 100
			errorsArr.push('Radius of beyond 100km not supported.')
		end

		minLatLon = -180
		maxLatLon = 180

		if !(minLatLon..maxLatLon).include?(latitude)
			errorsArr.push('Latitude is not within the range of -180 to 180.')
		end
		if !(minLatLon..maxLatLon).include?(longitude)
			errorsArr.push('Longitude is not within the range of -180 to 180.')
		end

		# Check if there are any errors so far, and if so, render json error.
		if errorsArr.count > 0
			return render_errors(errorsArr)
		end


		# Actual filtering logic happens here.
		# To keep the `SELECT` queries fast, we isolate the results by those that are within 1deg (lat/lon)
		# of the center. Once that is done, we calculate the distances and return them to the callee.
		lon1 = longitude - radius/(Math.cos(to_rad(latitude)).abs*69);
		lon2 = longitude + radius/(Math.cos(to_rad(latitude)).abs*69);
		lat1 = latitude - (radius/69);
		lat2 = latitude + (radius/69);

		# This query calculates the distance between the center and all the filtered points (filtered using the where clause)
		# Taken from https://www.scribd.com/doc/2569355/Geo-Distance-Search-with-MySQL
		selectQuery = "posts.*, 3956 * 2 * asin(sqrt( pow(sin((#{latitude} - posts.latitude) * pi()/180 / 2), 2) + cos(#{latitude} * pi()/180) * cos(posts.latitude * pi()/180) * power(sin((#{longitude} -posts.longitude) * pi()/180 / 2), 2) )) AS distance"

		allPosts = allPosts.where(latitude: (lat1..lat2), longitude: (lon1..lon2)).select(selectQuery)
		return allPosts
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

		def to_rad(degrees)
			return degrees/180 * Math::PI
		end

end
