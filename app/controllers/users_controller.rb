class UsersController < ApplicationController
  before_action :logged_in, only: [:index, :show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin, only: [:index, :show, :edit, :update]
  before_action :authorize_user, only: [:show, :edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    if !admin?
      flash[:danger] = 'You are not authorized to view this page!'
      redirect_to root_url
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        log_in @user
        flash[:success] = 'Welcome to the And We\'re Walking Fundraising App! You are ready to start bidding!'
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:info] = 'Profile was successfully updated.'
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      flash[:info] = 'User was successfully deleted from the system.'
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def authorize_admin
      redirect_to(root_url) unless admin?
    end

    def authorize_user
      redirect_to(root_url) unless current_user.id==params[:id] || admin?
    end

    def logged_in
      unless logged_in?
        flash[:warning] = "Please log in!"
        redirect_to login_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email, :notify_by_text, :notify_by_email, :name_visible, :phone_number)
    end
end
