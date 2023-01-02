class AuthorsController < ApplicationController

	protect_from_forgery
  skip_before_action :verify_authenticity_token
	before_action :find_auhtor, only: ['index','update','destroy'] 

	def index
		@authors = Author.all
		render json: @authors
	end

	def create
		@author = Author.new(author_params)
		if @author.save
			render json: @author
		else
			render json: 'Author creation failure'
		end	
	end

	def update
		if @author.update(author_params)
			render json: @author
		else
			render json: 'Author update failure'
		end	
	end

	def destroy
		if @author.destroy
			render json: 'Author delete successfully'
		else
			render json: 'Author delete failure'
		end
	end	

	def find_auhtor
		@author = Author.find(params[:id])
	end

	private
		def author_params
			params.permit(
										:name,
										:email,
										posts_attributes: [
														:title,
														:content,
														:subject,
														:publish_date
													]
										)
		end
end
