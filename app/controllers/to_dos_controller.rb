class ToDosController < ApplicationController

	def new
		# @ToDo = todo.new
	end

	def create
		render plain: params[:to_do].inspect
	end

	def index
		
	end

end
