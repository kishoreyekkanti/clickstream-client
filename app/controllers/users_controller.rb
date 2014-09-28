class UsersController < ApplicationController
  def login
    render "login"
  end

  def signin

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.password_confirmation == @user.password
      @user.password = @user.encrypt_password(@user.password)
      @user.current_token_details = generate_token_details
      @user.id = @user.email if @user.id.nil?
      if(@user.save)
        redirect_to(@user)
      else
        render :action => 'new'
      end
    else
      puts "password and confirmaton doesn't match"
    end
  end

  def generate_token_details
    {current_token_details: {apitoken: SecureRandom.base64, valid_from: Time.now.to_i, valid_to: (Time.now + 365*24*60*60).to_i}}
  end

end