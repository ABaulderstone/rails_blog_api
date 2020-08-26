class PostsController < ApplicationController
        before_action :authenticate_user, except: [:index]
        # before_action :set_post, except: [:index, :create]

    
    def index 
        @posts = Post.all
        render json: @posts
    end 

    def show 
        puts params
        puts params[:id]
        @post = Post.find(params[:id])
        render json: @post
    end 

    private 
    
    def set_post 
        @post = Post.find(params[:id])
    end 
end
