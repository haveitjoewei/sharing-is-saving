class Users::SessionsController < Devise::SessionsController
  # skip_before_filter :authenticate_user!, :only => [:create, :new]
  # skip_before_filter :authenticate_user_from_token!, :only => [:create]
  # skip_before_filter :verify_signed_out_user, only: :destroy
  # skip_before_action :verify_authenticity_token

  # skip_authorization_check only: [:create, :failure, :show_current_user, :options, :new]
  # respond_to :json

  def new
    super
    # self.resource = resource_class.new(sign_in_params)
    # clean_up_passwords(resource)
    # respond_with(resource, serialize_options(resource))
    # response.headers['Access-Control-Allow-Origin'] = "*"# * means any. specify to 
  end

  # POST users/sign_in
  def create
    super
    # respond_to do |format|
    #   format.json {
    #     resource = resource_from_credentials
    #     # build_resource
    #     return invalid_login_attempt unless resource

    #     if resource.valid_password?(params[:password])
    #       render :json => { :status => 1, :user => { :email => resource.email, :auth_token => resource.authentication_token } }, success: true, status: :created
    #     else
    #       return invalid_login_attempt
    #     end
    #   }
    # end
  end

  # DELETE users/sign_out
  def destroy
    super
    # respond_to do |format|
    #   format.json {
    #     user = User.find_by_authentication_token(request.headers['X-API-TOKEN'])
    #     if user
    #       user.authentication_token = nil
    #       user.save
    #       render :json => { :status => 1, :message => 'Session deleted.' }, :success => true, :status => 200
    #     else
    #       render :json => { :status => -1, :message => 'Invalid token.' }, :status => 404
    #     end
    #   }
    # end
  end

  # api :GET, '/users/:id'
  # param :id, :number
  # def show
  #   # ...
  # end
  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected
  # def invalid_login_attempt
  #   warden.custom_failure!

  #   errorsArr = Array.new
  #   errorsArr.push 'Invalid user' 
  #   render :json => { 'status' => -1, 'errors' => errorsArr }, status: 401
  # end

  # def resource_from_credentials
  #   data = { email: params[:email] }
  #   if res = resource_class.find_for_database_authentication(data)
  #     if res.valid_password?(params[:password])
  #       res
  #     end
  #   end
  # end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
