class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :destroy, :update]

  def new
    @user = User.new
  end

  def index
    @user = User.where(trainer: true)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      if @user.trainer == true
        auto_login(@user)
        flash[:alert] = "Trainer signed up!"
        redirect_to user_url(@user)
      else
        auto_login(@user)
        flash[:alert] = "Trainee signed up!"
        redirect_to users_url
      end
    else
      flash[:alert] = "Failed to signed up!"
      render 'new'
    end
  end

  def show
    #  @user = User.find(params[:id])
    # client = Signet::OAuth2::Client.new(access_token: session[:access_token])
    # client.expires_in = Time.now + 1_000_000
    # service = Google::Apis::CalendarV3::CalendarService.new
    # service.authorization = client
    # @calendar_list = service.list_calendar_lists
  end

  def edit
  #  @user = User.find(params[:id])
  end

  def update
  #  @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_url
    else
      render :edit
    end
  end

  def destroy
  #  @user = User.find(params[:id])
    @user.destroy
    redirect_to :new
  end

private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :address, :trainer, :password, :password_confirmation)
  end
end
