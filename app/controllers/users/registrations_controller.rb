class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]  

  # GET /resource/sign_up
  def new
    super
  end

  # POST /users
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  def view
    @allNotificationsForCompletedTransactions = PublicActivity::Activity.all.where(:key => 'exchange.exchange_completed')
    @allExchanges = @allNotificationsForCompletedTransactions.reverse_order.map { |notification| ::Exchange.find(notification.exchange_id)}

    @allExchanges = @allExchanges.select { |exchange| exchange.lender_id == current_user.id or exchange.borrower_id == current_user.id }

    @allExchangesAsLender = @allExchanges.select { |exchange| exchange.lender_id == current_user.id }
    @allPostsAsLender = @allExchangesAsLender.map { |exchange| ::Post.find(exchange.post_id)}
    @allBorrowersAsLender = @allExchangesAsLender.map { |exchange| ::User.find(exchange.borrower_id)}

    @allExchangesAsBorrower = @allExchanges.select { |exchange| exchange.borrower_id == current_user.id }
    @allPostsAsBorrower = @allExchangesAsBorrower.map { |exchange| ::Post.find(exchange.post_id)}
    @allLendersAsBorrower = @allPostsAsBorrower.map { |post| ::User.find(post.user_id)}

    @allPosts = ::Post.all.order(:created_at).reverse_order.where("user_id = ?", current_user.id)

    @allStatuses = @allPosts.map { |post| get_status(post.status)}

  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  def get_status(status)
    case status
    when 1    #compare to 1
      return "Available"
    when 2    #compare to 2
      return "Borrowed"
    else
      return "Unavailable"
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :current_password, :password, :password_confirmation, :first_name, :last_name, :date_of_birth, :latitude, :longitude)
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :current_password, :password, :password_confirmation, :first_name, :last_name, :date_of_birth, :latitude, :longitude)
    end
    # devise_parameter_sanitizer.for(:account_update) << :attribute
  end

  # def user_params
  #   params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :date_of_birth, :latitude, :longitude)
  # end


  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  
end
