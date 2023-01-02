class PostsController < ApplicationController
	
	protect_from_forgery
  skip_before_action :verify_authenticity_token

	before_action :find_author
	
	def index
		@posts = @author.posts
	end

	def create
		@post = @author.posts.build(params.permit(:title,:content,:subject,:publish_date))
		if @post.save
			render json: @post
		else
			render json: 'Post creation failure'
		end
	end

	def update
		@post = @author.posts.find(params[:id])
		if @post.present?
			if @post.update(post_params)
				render json: @post
			else
				render json: 'Post updation failure'
			end	
		else
			render json: 'author post not found'
		end	
	end

	def destroy
		@post = @author.posts.find(params[:id])
		if @post.present?
			if @post.destroy
				render json: 'Post delete successfully'
			else
				render json: 'Post delete failure'
			end	
		else
			render json: 'author post not found'
		end	
	end	

	private

	def find_author
		@author = Author.find(params[:author_id])
	end	


	def post_params
		params.permit(:title,:content,:subject,:publish_date)
	end	
end
