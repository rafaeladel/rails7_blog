class BlogPostsController < ApplicationController 
    before_action :authenticate_user!, except: [:index, :show]
    before_action :fetch_post, only: [:show, :edit, :update, :destroy]

    def index
      @blog_posts = user_signed_in? ? BlogPost.all : BlogPost.published
    end

    def show
    end

    def new
        @blog_post = BlogPost.new
    end

    def create
      @blog_post = BlogPost.new(post_params)
      if (@blog_post.save) 
        redirect_to blog_posts_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @blog_post.update(post_params) 
        redirect_to @blog_post
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
     @blog_post.destroy
     redirect_to root_path 
    end

    private
    def fetch_post
      @blog_post = user_signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Post not found!"
      redirect_to root_path
    end

    def post_params 
      params.require(:blog_post).permit(:title, :body, :email, :published_at, :image, :cover)
    end
end
