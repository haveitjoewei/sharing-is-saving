class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  # acts_as_token_authentication_handler_for User
  
  before_filter :cors_set_access_control_headers
  before_filter :get_notifications

  def home
  end

  def options_for_mopd
    render :nothing => true, :status => 200
  end


  def get_notifications
    @allActivities = PublicActivity::Activity.all

    if @allActivities.count > 0 and current_user
      @allActivities = @allActivities.where("owner_id = ? or recipient_id = ?", current_user.id, current_user.id).order(:created_at).reverse_order

      @allOwnersN = @allActivities.map { |activity| ::User.find(activity.owner_id)}
      @allRecipientsN = @allActivities.map { |activity| ::User.find(activity.recipient_id)}
      @allExchangesN = @allActivities.map { |activity| ::Exchange.find(activity.exchange_id)}
      @allPostsN = @allActivities.map { |activity| ::Post.find(activity.post_id)}
    end

  end
  
  protected

  def handle_options_request
    head(:ok) if request.request_method == "OPTIONS"
  end

  def json_request?
    request.format.json?
  end
  
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = 'http://localhost'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*, X-Requested-With, X-Prototype-Version, X-CSRF-Token, Content-Type'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def render_errors(errorsArr)
    return render :json => {:status => -1, :errors => errorsArr}, :status => 404
  end

  private
  
  def authenticate_user_from_token!
    user_email = request.headers["X-API-EMAIL"].presence
    user_auth_token = request.headers["X-API-TOKEN"].presence

    if !user_email or !user_auth_token
      render :json => { :status => '-1', :message => 'Email or auth token is not present. Please add it to your headers using X-API-EMAIL and X-API-TOKEN.' }, :status => 404
      return
    end

    user = user_email && User.find_by_email(user_email)

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, user_auth_token)
      sign_in(user, store: false)
    else
	    render :json => { :status => '-1', :message => 'Email and token combination is invalid.' }, :status => 404
      return
    end
  end
end
