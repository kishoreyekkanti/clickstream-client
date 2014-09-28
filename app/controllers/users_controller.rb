class UsersController < ApplicationController
  def login
    if session[:user_email]
      redirect_to dashboard_path
    else
      render "login"
    end

  end

  def signin

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

  def create_new_user
    if @user.password_confirmation == @user.password
      @user.password = @user.encrypt_password(@user.password)
      @user.current_token_details = generate_token_details
      @user.id = @user.email if @user.id.nil?
      if (@user.save)
        session[:user_email] = @user.email
        render :action => 'dashboard'
      else
        render :action => 'new'
      end
    else
      puts "password and confirmation doesn't match"
    end
  end

  def dashboard
    puts "XYZSFDSFDSFSDFDSFDS",session[:user_email]
  end

  def generate_token_details
    {current_token_details: {apitoken: SecureRandom.base64, valid_from: Time.now.to_i, valid_to: (Time.now + 365*24*60*60).to_i}}
  end

end