class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_user
  # GET /posts or /posts.json
  def index
    if (!logged_in)
      return
    end
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    if (!logged_in || !correct_user)
      return
    end
  end

  # GET /posts/new
  def new
    if (!logged_in || !correct_user)
      return
    end
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    if (!logged_in || !correct_user)
      return
    end
  end

  # POST /posts or /posts.json
  def create
    if (!logged_in || !correct_user)
      return
    end
    @post = Post.new(post_params)
    puts "-------------"
    puts params[:id]
    respond_to do |format|
      if @post.save
        format.html { redirect_to user_post_path(@user_id,@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if (!logged_in || !correct_user)
      return
    end
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to user_post_path(@user_id,@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if (!logged_in || !correct_user)
      return
    end
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_path(@user_id), notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  # /posts
  def post_new
    if (!logged_in)
      return
    end
    @post = Post.new()
  end

  def post_create
    if (!logged_in || !correct_user(params[:post][:user_id]))
      return
    end
    @post = Post.new(post_params)
    if (@post.save)
      redirect_to user_post_path(@post.user, @post), notice: "create post successfully"
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = User.find(params[:user_id]).posts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :msg)
    end

    def set_user
      @user_id = params[:user_id]
    end

    def logged_in
      if (session[:user_id])
          return true
      else
        redirect_to "/main", notice: "Please login"
        return false
      end
    end

    def correct_user(user_id = params[:user_id])
      puts "VVVVV"
      puts params[:user_id].to_i == session[:user_id]
      if (user_id.to_i == session[:user_id])
        return true
      else
        redirect_to "/main", notice: "No permission"
        return false
      end
    end

end
