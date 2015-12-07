class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  # acts_as_token_authentication_handler_for User
  
  before_filter :cors_set_access_control_headers
  before_filter :get_notifications

  def home
  end

  def get_notifications
    @allActivities = PublicActivity::Activity.all

    if @allActivities.count > 0 and current_user
      @allActivities = @allActivities.where("owner_id = ? or recipient_id = ?", current_user.id, current_user.id).order(:created_at).reverse_order

      @allOwnersN = @allActivities.map { |activity| ::User.find(activity.owner_id)}
      @allRecipientsN = @allActivities.map { |activity| ::User.find(activity.recipient_id)}
      @allExchangesN = @allActivities.map { |activity| ::Exchange.find(activity.exchange_id)}
      @allPostsN = @allActivities.map { |activity| ::Post.find(activity.post_id)}

      # @allNotificationsForCompletedTransactions = PublicActivity::Activity.all.where(:key => 'exchange.exchange_completed')
      @allExchanges = PublicActivity::Activity.all.reverse_order.map { |activity| ::Exchange.find(activity.exchange_id)}

      # @allExchanges = @allExchanges.select { |exchange| exchange.lender_id == current_user.id or exchange.borrower_id == current_user.id }
      @allExchangesAsLender = @allExchanges.select { |exchange| exchange.lender_id == current_user.id }
      # @allPostsAsLender = @allOwnersN.map { |exchange| ::Post.find(exchange.post_id)}
      # @allBorrowersAsLender = @allPostsAsLender.map { |post| ::User.find(post.user_id)}

      @allExchangesAsBorrower = @allExchanges.select { |exchange| exchange.borrower_id == current_user.id }
      @allPostsAsBorrower = @allExchangesAsBorrower.map { |exchange| ::Post.find(exchange.post_id)}
      @allLendersAsBorrower = @allPostsAsBorrower.map { |post| ::User.find(post.user_id)}

      @allPosts = ::Post.all.order(:created_at).reverse_order.where("user_id = ?", current_user.id)

      # @allStatuses = @allPosts.map { |post| get_status(post.status)}
    end

  end
  protected

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = 'http://localhost'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*, X-Requested-With, X-Prototype-Version, X-CSRF-Token, Content-Type'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def render_errors(errorsArr)
    return render :json => {:status => -1, :errors => errorsArr}, :status => 404
  end

end
