class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy]
  # before_action(:set_user, only: [:show,:edit,:update,:destroy])

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @posts = @user.posts
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    render 'destroy'
    # respond_to do |format|
    #   format.html { redirect_to users_url, notice: "User was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  def create_fast
    name = params[:name]
    email = params[:email]
    birthday = params[:birthday]
    address = params[:address]
    postal_code = params[:postal_code]
    @user = User.create(name: name, email: email, birthday: birthday, address: address, postal_code: postal_code)
    # redirect_to 'users_path'
    render 'create_fast'
  end

  def main

  end

  def login
    puts params[:email]
    puts params[:pass]
    @user = User.find_by(email: params[:email])
    respond_to do |format|
      if @user != nil
        puts @user.pass
        puts params[:pass]
        if @user.pass == params[:pass]
          format.html { redirect_to @user }
        else
          format.html { redirect_to "/main", notice: "Wrong password" }
        end
      else
        format.html { redirect_to "/main", notice: "Invalid email" }
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name, :birthday,:address, :postal_code, :pass)
    end
end
