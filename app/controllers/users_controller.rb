class UsersController < ApplicationController
  def login
    if session[:user_email]
      redirect_to dashboard_path
    else
      @user = User.new
      render "login"
    end
  end

  def login_verify
    @incoming_user_details = params[:user]
    puts @incoming_user_details.inspect
    @user = User.find_by_id(@incoming_user_details[:email])
    if User.encrypt_password(@incoming_user_details[:password]) == @user.password
      session[:user_email] = @user.email
      redirect_to dashboard_path
    else
      redirect_to users_login_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if User.find_by_id(@user.email)
      flash[:error] = "Email id already registered"
      render "new"
    else
      create_new_user
    end
  end

  def get
    @user  = User.find_by_id(params[:email])
    respond_to do |format|
      format.json { render json: {"valid" => @user? true: false} };
      format.html { render json: {"valid" => @user? true: false} };
    end
  end

  def logout
    session[:user_email] = nil
    redirect_to users_login_path
  end

  def welcome
    if session[:user_email]
      @user_email = session[:user_email]
      @user = User.find_by_id(@user_email)
      @apiToken = @user.current_token_details[:apitoken]
    else
      redirect_to users_login_path
    end
  end

  def profile
    if session[:user_email]
      @user_email = session[:user_email]
      @user = User.find_by_id(@user_email)
    else
      redirect_to users_login_path
    end
  end

  private

  def create_new_user
    if @user.password_confirmation == @user.password
      @user.password = User.encrypt_password(@user.password)
      @user.current_token_details = generate_token_details
      @user.hostname = URI.parse(@user.website).host
      @user.id = @user.email if @user.id.nil?
      if @user.save
        session[:user_email] = @user.email
        save_api_token_details(@user)
        redirect_to users_welcome_path
      else
        render :action => 'new'
      end
    else
      puts "password and confirmation doesn't match"
    end
  end

  def save_api_token_details(user)
    api = ApiTokens.new(get_apitoken_details(user))
    api.id = user.current_token_details[:apitoken]
    api.save
  end

  def generate_token_details
    {apitoken: get_random_token, valid_from: Time.now.to_i*1000, valid_to: ((Time.now + 365*24*60*60).to_i)*1000}
  end

  def get_random_token
    random = SecureRandom.base64
    if ApiTokens.find_by_id(random)
      get_random_token
    end
    random
  end

  def get_apitoken_details(user)
    api_details = user.current_token_details
    {valid_from: api_details[:valid_from], valid_to: api_details[:valid_to], userid: user.email, hostname: user.hostname}
  end
end