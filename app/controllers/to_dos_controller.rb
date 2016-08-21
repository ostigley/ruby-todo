class ToDosController < ApplicationController

	def new
		@to_do = ToDo.new
		@projects =  Project.all
	end

	def create
		@to_do = ToDo.new(to_do_params)
		
		if @to_do.save
			redirect_to to_dos_path
		else 
			render 'new'
		end

	end

	def show
		@to_do = ToDo.find(params[:id])
	end

	def index
		@projects = Project.all
		@to_dos = ToDo.all
	end

	def destroy
		@to_do = ToDo.find(params[:id])
		@to_do.destroy
		flash[:success] = 'Nice job'
		redirect_to to_dos_path
	end

	private
		def to_do_params
			params.require(:to_do).permit(:task, :project_id)
		end


end
