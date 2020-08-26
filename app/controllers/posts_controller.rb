class PostsController < ApplicationController
        before_action :authenticate_user, except: [:index]
        before_action :set_post, except: [:index, :create]
        before_action :has_authority, only: [:update, :delete]

    def create 
        @post = current_user.posts.create(post_params)
        if @post.errors.any?
            render json: @post.errors, status: :unprocessable_entity 
        else 
            render json: transform_post(@post), status: 201
        end 

    end 

    def index 
        @posts = Post.all.includes(:user, :category)
        render json: transform_post_array(@posts)
    end 

    def show 
        puts current_user.admin?
        render json: @post
    end 

    def update 
        @post.update(post_params)
        if @post.errors.any?
            render json: @post.errors, status: :unprocessable_entity 
        else 
            render json: @post, status: 200
        end 
    end

    private 
    
    def set_post 
        @post = Post.find(params[:id])
    end 
    def transform_post(post) 
        {
            content: post.content, 
            title: post.title,
            author: post.user.username,
            category: post.category.name
        }
    end 


    def transform_post_array(post_array)
        post_array.map { |post| transform_post(post) }
    end


    def has_authority 
        unless current_user.id == @post.user_id || current_user.admin? 
            render json: {error: "Unauthorised"}, status: 401
        end 
    end 

    def post_params
        params.require(:post).permit(:title, :content, :category_id)
    end 
end
