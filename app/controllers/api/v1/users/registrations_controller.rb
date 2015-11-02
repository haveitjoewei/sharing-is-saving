class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token 
  skip_before_filter :authenticate_user!, :only => [:create]
  skip_before_filter :authenticate_user_from_token!, :only => [:create]
  respond_to :json
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]  

  # GET /resource/sign_up
  def new
    super
  end

  # POST /users
  def create
    response.headers['Access-Control-Allow-Origin'] = "*"# * means any. specify to 
    response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    response.headers['Access-Control-Request-Method'] = '*'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'

    @user = User.where(email: params[:user][:email])
    if !@user.empty?
      render :json => {:status => -1, :message => 'Couldn\'t create account because email already exists.'}, :status => 404
      return
    end

    build_resource(sign_up_params)
    resource.save
    
    yield resource if block_given?
    if resource.persisted?
      # resource_without_token['created_at'] = resource_without_token['created_at'].to_f # TODO(SID): to fix
      # resource_without_token['updated_at'] = resource_without_token['updated_at'].to_f # TODO(SID): to fix
      render :json => {:status => 1, :user => resource}, except: [:authentication_token]
      return
    else
      clean_up_passwords resource
      set_minimum_password_length
      render :json => {:status => -1, :errors => resource.errors.full_messages}
      return
    end

    

  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /users
  # Custom name, because the original does not work well with simple_token_authentication
  def update_user
    currentUserId = current_user.id
    if current_user.update_attributes(user_params)
      render :json => {:status => 1}, :status => 200
      return 
    else
      render :json => {:status => -1, :message => 'Updating user failed.' }, :status => 404
      return
    end
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

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :date_of_birth, :latitude, :longitude)
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :date_of_birth, :latitude, :longitude)
    end
    # devise_parameter_sanitizer.for(:account_update) << :attribute
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :date_of_birth, :latitude, :longitude)
  end


  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
